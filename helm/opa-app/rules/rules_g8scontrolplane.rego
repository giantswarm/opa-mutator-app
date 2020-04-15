package admission

import data.functions
import data.vars

deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    is_number(input.request.object.spec.replicas)
    not functions.array_contains(vars.validReplicas, input.request.object.spec.replicas)
    msg = "Invalid number of Master Node replicas"
}

patch["default_replicas"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    is_null(input.request.object.spec.replicas)
    mutation := [
        {"op": "add", "path": "/spec/replicas", "value": vars.defaultReplicas},
    ]
}