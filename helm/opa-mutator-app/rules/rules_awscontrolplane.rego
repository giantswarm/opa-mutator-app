package admission

import data.functions
import data.vars

# User has selected invalid availability zones
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    is_array(input.request.object.spec.availabilityZones)
    functions.array_not_subset(vars.validAZs, input.request.object.spec.availabilityZones)
    msg = "Invalid choice of Master Node Availability Zones"
}

# User has selected the same availability zone twice
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    is_array(input.request.object.spec.availabilityZones)
    functions.array_not_unique(input.request.object.spec.availabilityZones)
    msg = "The same Master Node Availability Zone can not be selected more than once"
}

# User has selected a wrong number of AZ
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    is_array(input.request.object.spec.availabilityZones)
    not functions.array_contains(vars.validReplicas, count(input.request.object.spec.availabilityZones))
    msg = "Invalid number of Availability Zones"
}

# User has selected different number of AZ than the replicas in the G8sControlPlane
deny[msg] {
    functions.is_create
    input.request.kind.kind = "AWSControlPlane"
    input.request.name = data.kubernetes.g8scontrolplanes[input.request.namespace][n].metadata.name
    not is_null(input.request.object.spec.availabilityZones)
    data.kubernetes.g8scontrolplanes[input.request.namespace][n].spec.replicas != count(input.request.object.spec.availabilityZones)
    msg = "Number of Availability Zones different than defined in G8SControlPlane"
}

# Defaulting: user has not selected any AZs and there is no G8sControlPlane that has to be matched
patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    is_null(input.request.object.spec.availabilityZones)
    not data.kubernetes.g8scontrolplanes[input.request.namespace][input.request.name]
    mutation := [
        {"op": "add", "path": "/spec~1availabilityZones", "value": functions.n_shifted_values(vars.validAZs, vars.defaultReplicas)},
    ]
}

# Defaulting: User has not selected any AZs but there is a G8sControlPlane that has to be matched
patch["default_az_withg8s"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    input.request.name = data.kubernetes.g8scontrolplanes[input.request.namespace][n].metadata.name
    is_null(input.request.object.spec.availabilityZones)
    mutation := [
        {"op": "add", "path": "/spec~1availabilityZones", "value": functions.n_shifted_values(vars.validAZs, data.kubernetes.g8scontrolplanes[input.request.namespace][n].spec.replicas)},
    ]
}

patch["default_cidr"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    input.request.object.apiVersion = "infrastructure.giantswarm.io/v1"
    is_null(input.request.object.spec.provider.cni)
    mutation := [
        {"op": "add", "path": "/spec~1provider~1cni", "value": {"cidrBlock":  sprintf("%s/%s", [vars.defaultSubnet, vars.defaultCIDR]) }},
    ]
}
