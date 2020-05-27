package admission

import data.functions
import data.vars

# User has selected invalid availability zone
# This is for older nodepool clusters that still use the `Master` field
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    az = input.request.object.spec.provider.master.availabilityZone
    functions.is_defined(az)
    not functions.array_contains(vars.validAZs, az)
    msg = "Invalid choice of Master Node Availability Zone"
}

# User has selected an invalid instance type
# This is for older nodepool clusters that still use the `Master` field
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    instanceType = input.request.object.spec.provider.master.instanceType
    functions.is_defined(instanceType)
    not functions.array_contains(vars.validInstanceTypes, instanceType)
    msg = "Invalid choice of Master Node Instance Type"
}

# Defaulting: user has not selected any master node instance type
# This is for older nodepool clusters that still use the `Master` field
patch["default_instance_type"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    instanceType = input.request.object.spec.provider.master.instanceType
    vars.is_preHA_nodepool_version
    functions.is_null_or_empty(instanceType)
    mutation := [
        {"op": "add", "path": "/spec/provider/master/instanceType", "value": vars.defaultInstanceType},
    ]
}

# Defaulting: user has not selected any master node availability zone
# This is for older nodepool clusters that still use the `Master` field
patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    az = input.request.object.spec.provider.master.availabilityZone
    vars.is_preHA_nodepool_version
    functions.is_null_or_empty(az)
    mutation := [
        {"op": "add", "path": "/spec/provider/master/availabilityZone", "value": functions.random_value(vars.validAZs)},
    ]
}

# Defaulting: user has not selected any pod cidr
patch["default_cidr"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    cidrBlock = input.request.object.spec.provider.pods.cidrBlock
    functions.is_null_or_empty(cidrBlock)
    mutation := [
        {"op": "add", "path": "/spec/provider/pods/cidrBlock", "value": sprintf("%s/%s", [vars.defaultSubnet, vars.defaultCIDR]) },
    ]
}
