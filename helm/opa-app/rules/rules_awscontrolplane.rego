package admission

import data.functions
import data.vars

deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    is_array(input.request.object.spec.availabilityZones)
    functions.array_not_subset(vars.validAZs, input.request.object.spec.availabilityZones)
    msg = "Invalid choice of Master Node Availability Zones"
}

deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    is_array(input.request.object.spec.availabilityZones)
    count(input.request.object.spec.availabilityZones) != vars.replicas
    msg = "Length of list of chosen Availability Zones has to match the number of Master Node replicas"
}

patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    is_null(input.request.object.spec.availabilityZones)
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": vars.defaultAZs},
    ]
}