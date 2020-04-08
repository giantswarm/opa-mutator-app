package admission

import data.functions
import data.vars

denyReplicas[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    input.request.spec.replicas
    not vars.validReplicas[input.request.spec.replicas]
    msg = "Invalid number of Master Node replicas"
}

patchReplicas["default_replicas"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    not input.request.spec.replicas
    mutation := [
        {"op": "add", "path": "/spec/replicas", "value": vars.defaultReplicas},
    ]
}