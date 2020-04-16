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

# User has selected a wrong number of AZ
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    is_array(input.request.object.spec.availabilityZones)
    not functions.array_contains(vars.validReplicas, count(input.request.object.spec.availabilityZones))
    msg = "Invalid number of Availability Zones"
}

# User has selected different number of AZ than the Control Plane
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    input.request.name = data.kubernetes.g8scontrolplanes[n].metadata.name
    not is_null(input.request.object.spec.availabilityZones)
    data.kubernetes.g8scontrolplanes[n].spec.replicas != count(input.request.object.spec.availabilityZones)
    msg = "Number of Availability Zones different than defined in G8SControlPlane"
}

patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    is_null(input.request.object.spec.availabilityZones)
    not data.kubernetes.g8scontrolplanes[input.request.name]
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": array.slice(vars.validAZs, 0, vars.defaultReplicas)},
    ]
}

patch["default_az_withg8s"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    input.request.name = data.kubernetes.g8scontrolplanes[n].metadata.name
    is_null(input.request.object.spec.availabilityZones)
    mutation := [
        {"op": "add", "path": "/spec/availabilityZones", "value": array.slice(vars.validAZs, 0, data.kubernetes.g8scontrolplanes[n].spec.replicas)},
    ]
}

patch["default_cidr"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    input.request.object.apiVersion = "infrastructure.giantswarm.io/v1"
    is_null(input.request.object.spec.provider.cni)
    mutation := [
        {"op": "add", "path": "/spec/provider/cni", "value": {"cidr": vars.defaultCIDR, "subnet": vars.defaultSubnet}},
    ]
}