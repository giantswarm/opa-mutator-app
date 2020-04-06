package admission

import data.functions

denyReplicas[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    validReplicas := functions.get_env_var(replicas)
    input.request.spec.replicas
    not validReplicas[input.request.spec.replicas]
    msg = "Invalid number of Master Node replicas"
}

denyAZ[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    validAZs := functions.get_env_var(AZ)
    input.request.spec.availabilityZones
    not validAZs[input.request.spec.availabilityZones]
    msg = "Invalid choice of Master Node Availability Zones"
}

denyAZcount[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    input.request.spec.availabilityZones
    count(input.request.spec.availabilityZones) != functions.get_env_var(replicas)
    msg = "Invalid choice of Master Node Availability Zones"
}

deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "ConfigMap"
    input.request.name = "test_bad"
    msg = "You cannot name it test_bad"
}

patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "ConfigMap"
    mutation := [
        {"op": "add", "path": "/metadata/annotations/foo", "value": functions.get_env_var("TEST_ENV")},
    ]
}