package admission

import data.functions
import data.vars

deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "ConfigMap"
    input.request.name = "test_bad"
    msg = "You cannot name it test_bad"
}

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

denyReplicas[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    input.request.spec.replicas
    not vars.validReplicas[input.request.spec.replicas]
    msg = "Invalid number of Master Node replicas"
}

patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "ConfigMap"
    mutation := [
        {"op": "add", "path": "/metadata/annotations/foo", "value": functions.get_env_var("TEST_ENV")},
    ]
}

patchAZ["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    not input.request.spec.availabilityZones
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": slice(vars.defaultAZs, 0, vars.replicas-1)},
    ]
}

patchReplicas["default_replicas"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    not input.request.spec.replicas
    mutation := [
        {"op": "add", "path": "/spec/replicas", "value": vars.defaultReplicas},
    ]
}