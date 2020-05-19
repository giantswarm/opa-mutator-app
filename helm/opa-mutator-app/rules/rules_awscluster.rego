package admission

import data.functions
import data.vars

# User has selected invalid availability zone
# This is for older nodepool clusters that still use the `Master` field
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    is_string(input.request.object.spec.provider.master.availabilityZone)
    count(input.request.object.spec.provider.master.availabilityZone) > 0
    not functions.array_contains(vars.validAZs, input.request.object.spec.provider.master.availabilityZone)
    msg = "Invalid choice of Master Node Availability Zone"
}

# User has selected an invalid instance type
# This is for older nodepool clusters that still use the `Master` field
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    is_string(input.request.object.spec.provider.master.instanceType)
    count(input.request.object.spec.provider.master.instanceType) > 0
    not functions.array_contains(vars.validInstanceTypes, input.request.object.spec.provider.master.instanceType)
    msg = "Invalid choice of Master Node Instance Type"
}

# Defaulting: user has not selected any master node instance type
# This is for older nodepool clusters that still use the `Master` field
patch["default_instance_type"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    vars.is_preHA_nodepool_version
    count(input.request.object.spec.provider.master.instanceType) == 0
    mutation := [
        {"op": "replace", "path": "/spec/provider~1master~1instanceType", "value": vars.defaultInstanceType},
    ]
}

# Defaulting: user has not selected any master node instance type
# This is for older nodepool clusters that still use the `Master` field
patch["default_instance_type"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    vars.is_preHA_nodepool_version
    is_null(input.request.object.spec.provider.master.instanceType)
    mutation := [
        {"op": "add", "path": "/spec/provider~1master~1instanceType", "value": vars.defaultInstanceType},
    ]
}

# Defaulting: user has not selected any master node availability
# This is for older nodepool clusters that still use the `Master` field
patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    vars.is_preHA_nodepool_version
    is_null(input.request.object.spec.provider.master.availabilityZone)
    mutation := [
        {"op": "add", "path": "/spec/provider~1master~availabilityZone", "value": functions.random_value(vars.validAZs)},
    ]
}

# Defaulting: user has not selected any master node availability
# This is for older nodepool clusters that still use the `Master` field
patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    vars.is_preHA_nodepool_version
    count(input.request.object.spec.provider.master.availabilityZone) == 0
    mutation := [
        {"op": "replace", "path": "/spec/provider~1master~availabilityZone", "value": functions.random_value(vars.validAZs)},
    ]
}

# Defaulting: user has not selected any pod cidr
patch["default_cidr"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    input.request.object.apiVersion = "infrastructure.giantswarm.io/v1"
    is_null(input.request.object.spec.provider.pods.cidrBlock)
    mutation := [
        {"op": "add", "path": "/spec/provider~1pods~1cidrBlock", "value": sprintf("%s/%s", [vars.defaultSubnet, vars.defaultCIDR]) },
    ]
}

# Defaulting: user has not selected any pod cidr
patch["default_cidr"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    #input.request.object.apiVersion = "infrastructure.giantswarm.io/v1"
    count(input.request.object.spec.provider.pods.cidrBlock) == 0
    mutation := [
        {"op": "replace", "path": "/spec/provider~1pods~1cidrBlock", "value": sprintf("%s/%s", [vars.defaultSubnet, vars.defaultCIDR]) },
    ]
}

