package admission

import data.functions
import data.vars

denyAZ[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    input.request.spec.availabilityZones
    not vars.validAZs[input.request.spec.availabilityZones]
    msg = "Invalid choice of Master Node Availability Zones"
}

denyAZcount[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    input.request.spec.availabilityZones
    count(input.request.spec.availabilityZones) != vars.replicas
    msg = "Length of list of chosen Availability Zones has to match the number of Master Node replicas"
}

patchAZ["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    not input.request.spec.availabilityZones
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": array.slice(vars.defaultAZs, 0, vars.replicas-1)},
    ]
}