package admission

import data.functions
import data.vars

# User has selected invalid availability zones
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    is_array(az)
    functions.array_not_subset(vars.validAZs, az)
    msg = "Invalid choice of Master Node Availability Zones"
}

# User has selected an invalid instance type
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    instanceType = input.request.object.spec.instanceType
    functions.is_defined(instanceType)
    not functions.array_contains(vars.validInstanceTypes, instanceType)
    msg = "Invalid choice of Master Node Instance Type"
}

# User has selected the same availability zone twice. this should only be possible
# in regions with limited AZs
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    not vars.isLimitedAZRegion
    is_array(az)
    functions.array_not_unique(az)
    msg = "The same Master Node Availability Zone can not be selected more than once"
}

# User has selected a wrong number of AZ
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    is_array(az)
    not functions.array_contains(vars.validReplicas, count(az))
    msg = "Invalid number of Availability Zones"
}

# User has selected different number of AZ than the replicas in the G8sControlPlane
deny[msg] {
    functions.is_create
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    functions.existsG8SControlPlane
    g8scp = functions.getG8SControlPlane
    functions.is_defined(az)
    g8scp.spec.replicas != count(az)
    msg = "Number of Availability Zones different than defined in G8SControlPlane"
}

# Defaulting: user has not selected any AZs and there is no G8sControlPlane that has to be matched
patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    functions.is_null_or_empty_attribute(input.request.object.spec, "availabilityZones")
    not functions.existsG8SControlPlane
    not vars.is_preHA_nodepool_version
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": functions.n_shifted_values(vars.validAZs, vars.defaultReplicas)},
    ]
}

# Defaulting: User has not selected any AZs but there is a G8sControlPlane that has to be matched
patch["default_az_withg8s"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    functions.is_null_or_empty_attribute(input.request.object.spec, "availabilityZones")
    functions.existsG8SControlPlane
    g8scp = functions.getG8SControlPlane
    not vars.is_preHA_nodepool_version
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": functions.n_shifted_values(vars.validAZs, g8scp.spec.replicas)},
    ]
}

# Defaulting: User has not selected any AZ, its a pre HA version and an awscluster exists
patch["default_az_preHA"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    functions.is_null_or_empty_attribute(input.request.object.spec, "availabilityZones")
    vars.is_preHA_nodepool_version
    functions.existsAWSCluster
    awscl = functions.getAWSCluster
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": [awscl.spec.provider.master.availabilityZone]},
    ]
}

# Defaulting: User has not selected any instance type, its a pre HA version and an awscluster exists
patch["default_instancetype_preHA"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    functions.is_null_or_empty_attribute(input.request.object.spec, "instanceType")
    vars.is_preHA_nodepool_version
    functions.existsAWSCluster
    awscl = functions.getAWSCluster
    mutation := [
        {"op": "add", "path": "/spec/instanceType", "value": awscl.spec.provider.master.instanceType},
    ]
}

# Defaulting: user has not selected any master node instance type
patch["default_instance_type"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    functions.is_null_or_empty_attribute(input.request.object.spec, "instanceType")
    not vars.is_preHA_nodepool_version
    mutation := [
        {"op": "add", "path": "/spec/instanceType", "value": vars.defaultInstanceType},
    ]
}

# On update we need to keep the order of AZs
deny[msg] {
    functions.is_update
    input.request.kind.kind = "AWSControlPlane"
    newAZ = input.request.object.spec.availabilityZones
    oldAZ = input.request.oldObject.spec.availabilityZones
    is_array(oldAZ)
    is_array(newAZ)
    functions.orderChanged(oldAZ, newAZ)
    msg = "Can not change the order of availability zones."
}

# On create we want to make sure that the AZs are sorted alphabetically
patch["sort_az"] = mutation {
    functions.is_create
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    is_array(az)
    sort(az)!=az
    mutation := [
        {"op": "replace", "path": "/spec/availabilityZones", "value": sort(az)},
    ]
}
