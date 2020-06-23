package admission

import data.functions
import data.vars

# User has selected a wrong number of replicas
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    replicas = input.request.object.spec.replicas
    is_number(replicas)
    not functions.array_contains(vars.validReplicas, replicas)
    msg = "Invalid number of Master Node replicas"
}

# User has selected different number of replicas than the AZs in AWSControlPlane
# This is allowed only on update
deny[msg] {
    functions.is_create
    input.request.kind.kind = "G8sControlPlane"
    replicas = input.request.object.spec.replicas
    functions.existsAWSControlPlane
    awscp = functions.getAWSControlPlane
    functions.is_defined(replicas)
    replicas != count(awscp.spec.availabilityZones)
    msg = "Number of Availability Zones different than defined in AWSControlPlane"
}

# Defaulting: user has not selected the number of replicas and there is no awscontrolplane that has to be matched
patch["default_replicas"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    functions.is_null_or_empty_attribute(input.request.object.spec, "replicas")

    not vars.is_preHA_nodepool_version
    not functions.existsAWSControlPlane
    mutation := [
        {"op": "add", "path": "/spec/replicas", "value": vars.defaultReplicas},
    ]
}

# Defaulting: User has not selected the number of replicas but there is a awscontrolplane that has to be matched
patch["default_replicas_withaws"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    functions.is_null_or_empty_attribute(input.request.object.spec, "replicas")
    functions.existsAWSControlPlane
    awscp = functions.getAWSControlPlane
    not vars.is_preHA_nodepool_version
    mutation := [
        {"op": "add", "path": "/spec/replicas", "value": count(awscp.spec.availabilityZones)},
    ]
}

# Defaulting: replicas are always 1 in pre-ha versions
patch["default_replicas_preHA"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "G8sControlPlane"
    functions.is_null_or_empty_attribute(input.request.object.spec, "replicas")
    vars.is_preHA_nodepool_version
    mutation := [
        {"op": "add", "path": "/spec/replicas", "value": 1},
    ]
}
