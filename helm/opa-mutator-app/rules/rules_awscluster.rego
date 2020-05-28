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
    is_string(instanceType)
    count(instanceType) > 0
    not functions.array_contains(vars.validInstanceTypes, instanceType)
    msg = "Invalid choice of Master Node Instance Type"
}

# Defaulting: user has not selected any master node instance type
# This is for older nodepool clusters that still use the `Master` field
patch["default_instance_type"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    vars.is_preHA_nodepool_version
    functions.is_null_or_empty_attribute(input.request.object.spec.provider.master, "instanceType")
    mutation := [
        {"op": "add", "path": "/spec/provider/master/instanceType", "value": vars.defaultInstanceType},
    ]
}

# Defaulting: user has not selected any master node availability zone
# This is for older nodepool clusters that still use the `Master` field
patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    vars.is_preHA_nodepool_version
    functions.is_null_or_empty_attribute(input.request.object.spec.provider.master, "availabilityZone")
    mutation := [
        {"op": "add", "path": "/spec/provider/master/availabilityZone", "value": functions.random_value(vars.validAZs)},
    ]
}

# Defaulting: user has not selected any pod cidr
patch["default_cidr"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    functions.is_null_or_empty_attribute(input.request.object.spec.provider.pods, "cidrBlock")
    mutation := [
        {"op": "add", "path": "/spec/provider/pods/cidrBlock", "value": sprintf("%s/%s", [vars.defaultSubnet, vars.defaultCIDR]) },
    ]
}
