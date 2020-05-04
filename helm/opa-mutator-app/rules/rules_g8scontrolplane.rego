package admission

import data.functions
import data.vars

# User has selected a wrong number of replicas
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    is_number(input.request.object.spec.replicas)
    not functions.array_contains(vars.validReplicas, input.request.object.spec.replicas)
    msg = "Invalid number of Master Node replicas"
}

# User has selected different number of replicas than the AZs in AWSControlPlane
# This is allowed only on update
deny[msg] {
    functions.is_create
    input.request.kind.kind = "G8sControlPlane"
    input.request.name = data.kubernetes.awscontrolplanes[input.request.namespace][n].metadata.name
    not is_null(input.request.object.spec.replicas)
    input.request.object.spec.replicas != count(data.kubernetes.awscontrolplanes[input.request.namespace][n].spec.availabilityZones)
    msg = "Number of Availability Zones different than defined in AWSControlPlane"
}

# Defaulting: user has not selected the number of replicas and there is no awscontrolplane that has to be matched
patch["default_replicas"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    is_null(input.request.object.spec.replicas)
    not data.kubernetes.awscontrolplanes[input.request.namespace][input.request.name]
    mutation := [
        {"op": "add", "path": "spec/replicas", "value": vars.defaultReplicas},
    ]
}

# Defaulting: User has not selected the number of replicas but there is a awscontrolplane that has to be matched
patch["default_replicas_withaws"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    input.request.name = data.kubernetes.awscontrolplanes[input.request.namespace][n].metadata.name
    is_null(input.request.object.spec.replicas)
    mutation := [
        {"op": "add", "path": "spec/replicas", "value": count(data.kubernetes.awscontrolplanes[input.request.namespace][n].spec.availabilityZones)},
    ]
}
