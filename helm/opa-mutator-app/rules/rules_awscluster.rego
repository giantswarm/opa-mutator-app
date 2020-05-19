package admission

import data.functions
import data.vars

# User has selected invalid availability zone
# This is for older nodepool clusters that still use the `Master` field
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    az = input.request.object.spec.provider.master.availabilityZone
    is_string(az)
    count(az) > 0
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
    instanceType = input.request.object.spec.provider.master.instanceType
    vars.is_preHA_nodepool_version
    is_string(instanceType)
    count(instanceType) == 0
    mutation := [
        {"op": "replace", "path": "/spec/provider~1master~1instanceType", "value": vars.defaultInstanceType},
    ]
}

# Defaulting: user has not selected any master node instance type
# This is for older nodepool clusters that still use the `Master` field
patch["default_instance_type"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    instanceType = input.request.object.spec.provider.master.instanceType
    vars.is_preHA_nodepool_version
    is_null(instanceType)
    mutation := [
        {"op": "add", "path": "/spec/provider~1master~1instanceType", "value": vars.defaultInstanceType},
    ]
}

# Defaulting: user has not selected any master node availability
# This is for older nodepool clusters that still use the `Master` field
patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    az = input.request.object.spec.provider.master.availabilityZone
    vars.is_preHA_nodepool_version
    is_null(az)
    mutation := [
        {"op": "add", "path": "/spec/provider~1master~availabilityZone", "value": functions.random_value(vars.validAZs)},
    ]
}

# Defaulting: user has not selected any master node availability
# This is for older nodepool clusters that still use the `Master` field
patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    az = input.request.object.spec.provider.master.availabilityZone
    vars.is_preHA_nodepool_version
    is_string(az)
    count(az) == 0
    mutation := [
        {"op": "replace", "path": "/spec/provider~1master~availabilityZone", "value": functions.random_value(vars.validAZs)},
    ]
}

# Defaulting: user has not selected any pod cidr
patch["default_cidr"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    cidrBlock = input.request.object.spec.provider.pods.cidrBlock
    input.request.object.apiVersion = "infrastructure.giantswarm.io/v1"
    is_null(cidrBlock)
    mutation := [
        {"op": "add", "path": "/spec/provider~1pods~1cidrBlock", "value": sprintf("%s/%s", [vars.defaultSubnet, vars.defaultCIDR]) },
    ]
}

# Defaulting: user has not selected any pod cidr
patch["default_cidr"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    cidrBlock = input.request.object.spec.provider.pods.cidrBlock
    input.request.object.apiVersion = "infrastructure.giantswarm.io/v1"
    is_string(cidrBlock)
    count(cidrBlock) == 0
    mutation := [
        {"op": "replace", "path": "/spec/provider~1pods~1cidrBlock", "value": sprintf("%s/%s", [vars.defaultSubnet, vars.defaultCIDR]) },
    ]
}

