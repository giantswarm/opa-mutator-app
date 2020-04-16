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

deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    input.request.name = data.kubernetes.awscontrolplanes[n].metadata.name
    not is_null(input.request.object.spec.replicas)
    input.request.object.spec.replicas != count(data.kubernetes.awscontrolplanes[n].spec.availabilityZones)
    msg = "Number of Availability Zones different than defined in AWSControlPlane"
}

patch["default_replicas"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    is_null(input.request.object.spec.replicas)
    not data.kubernetes.awscontrolplanes[input.request.name]
    mutation := [
        {"op": "add", "path": "/spec/replicas", "value": vars.defaultReplicas},
    ]
}

patch["default_replicas_withaws"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    input.request.name = data.kubernetes.awscontrolplanes[n].metadata.name
    is_null(input.request.object.spec.replicas)
    mutation := [
        {"op": "add", "path": "/spec/replicas", "value": count(data.kubernetes.awscontrolplanes[n].spec.availabilityZones)},
    ]
}