package admission

import data.functions
import data.vars

# User has selected invalid availability zones
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    is_array(az)
    functions.array_not_subset(vars.validAZs, az)
    msg = "Invalid choice of Master Node Availability Zones"
}

# User has selected an invalid instance type
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    instanceType = input.request.object.spec.instanceType
    functions.is_defined(instanceType)
    not functions.array_contains(vars.validInstanceTypes, instanceType)
    msg = "Invalid choice of Master Node Instance Type"
}

# User has selected the same availability zone twice. this should only be possible
# in regions with limited AZs
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    not vars.isLimitedAZRegion
    is_array(az)
    functions.array_not_unique(az)
    msg = "The same Master Node Availability Zone can not be selected more than once"
}

# User has selected a wrong number of AZ
deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    is_array(az)
    not functions.array_contains(vars.validReplicas, count(az))
    msg = "Invalid number of Availability Zones"
}

# User has selected different number of AZ than the replicas in the G8sControlPlane
deny[msg] {
    functions.is_create
    input.request.kind.kind = "AWSControlPlane"
    az = input.request.object.spec.availabilityZones
    functions.existsG8SControlPlane
    g8scp = functions.getG8SControlPlane
    functions.is_defined(az)
    g8scp.spec.replicas != count(az)
    msg = "Number of Availability Zones different than defined in G8SControlPlane"
}

# On update we need to keep the order of AZs
deny[msg] {
    functions.is_update
    input.request.kind.kind = "AWSControlPlane"
    newAZ = input.request.object.spec.availabilityZones
    oldAZ = input.request.oldObject.spec.availabilityZones
    is_array(oldAZ)
    is_array(newAZ)
    functions.orderChanged(oldAZ, newAZ)
    msg = "Can not change the order of availability zones."
}

