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
