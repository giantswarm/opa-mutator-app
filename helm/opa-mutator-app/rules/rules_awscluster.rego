package admission

import data.functions
import data.vars

# User has selected invalid availability zone
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    is_string(input.request.object.spec.provider.master.availabilityZone)
    not functions.array_contains(vars.validAZs, input.request.object.spec.provider.master.availabilityZone)
    msg = "Invalid choice of Master Node Availability Zones"
}

# User has selected an invalid instance type
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    is_string(input.request.object.spec.provider.master.instanceType)
    not functions.array_contains(vars.validAZs, input.request.object.spec.provider.master.instanceType)
    msg = "Invalid choice of Master Node Instance Type"
}

# Defaulting: user has not selected any master node instance type
patch["default_instance_type"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSCluster"
    vars.is_legacy_nodepool_version
    is_null(input.request.object.spec.provider.master.instanceType)
    mutation := [
        {"op": "add", "path": "/spec/provider~1master~1instanceType", "value": vars.defaultInstanceType},
    ]
}
