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
    is_string(instanceType)
    count(instanceType) > 0
    not functions.array_contains(vars.validInstanceTypes, instanceType)
    msg = "Invalid choice of Master Node Instance Type"
}


# User has selected the same availability zone twice
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
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
    input.request.name = data.kubernetes.g8scontrolplanes[input.request.namespace][n].metadata.name
    not is_null(az)
    data.kubernetes.g8scontrolplanes[input.request.namespace][n].spec.replicas != count(az)
    msg = "Number of Availability Zones different than defined in G8SControlPlane"
}

# Defaulting: user has not selected any AZs and there is no G8sControlPlane that has to be matched
patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    is_null(az)
    not data.kubernetes.g8scontrolplanes[input.request.namespace][input.request.name]
    not vars.is_preHA_nodepool_version
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": functions.n_shifted_values(vars.validAZs, vars.defaultReplicas)},
    ]
}

# Defaulting: User has not selected any AZs but there is a G8sControlPlane that has to be matched
patch["default_az_withg8s"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    input.request.name = data.kubernetes.g8scontrolplanes[input.request.namespace][n].metadata.name
    is_null(az)
    not vars.is_preHA_nodepool_version
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": functions.n_shifted_values(vars.validAZs, data.kubernetes.g8scontrolplanes[input.request.namespace][n].spec.replicas)},
    ]
}

# Defaulting: User has not selected any AZ, its a pre HA version and an awscluster exists
patch["default_az_preHA"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    is_null(az)
    vars.is_preHA_nodepool_version
    functions.hasLabel["giantswarm.io/cluster"]
    input.request.object.metadata.labels["giantswarm.io/cluster"] = data.kubernetes.awsclusters[input.request.namespace][n].metadata.name
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": [data.kubernetes.awsclusters[input.request.namespace][n].spec.provider.master.availabilityZone]},
    ]
}

# Defaulting: user has not selected any master node instance type
patch["default_instance_type"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    instanceType = input.request.object.spec.instanceType
    is_null(instanceType)
    mutation := [
        {"op": "add", "path": "/spec/instanceType", "value": vars.defaultInstanceType},
    ]
}

# Defaulting: user has not selected any master node instance type
patch["default_instance_type"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    instanceType = input.request.object.spec.instanceType
    is_string(instanceType)
    count(instanceType) == 0
    mutation := [
        {"op": "add", "path": "/spec/instanceType", "value": vars.defaultInstanceType},
    ]
}

