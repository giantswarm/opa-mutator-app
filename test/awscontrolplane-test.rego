package test

import data.admission
import data.functions
import data.mocks

# a non valid AZ name
test_create_invalid_awscontrolplane {
    deny = admission.deny with input as mocks.create_invalid_awscontrolplane
    contains(deny[_], "Invalid choice of Master Node Availability Zones")
    count(deny) = 1
}

# a non valid instance type
test_create_invalid_instancetype_awscontrolplane {
    deny = admission.deny with input as mocks.create_invalid_instancetype_awscontrolplane
    contains(deny[_], "Invalid choice of Master Node Instance Type")
    count(deny) = 1
}

# a selection of AZs containing a duplicate
test_create_duplicate_awscontrolplane {
    deny = admission.deny with input as mocks.create_duplicate_awscontrolplane
    contains(deny[_], "The same Master Node Availability Zone can not be selected more than once")
    count(deny) = 1
}

# a non valid number of AZs
test_create_invalid_count_awscontrolplane {
    deny = admission.deny with input as mocks.create_invalid_count_awscontrolplane
    contains(deny[_], "Invalid number of Availability Zones")
    count(deny) = 1
}

# a valid choice of AZs
test_create_valid_awscontrolplane {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_single
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_single

    count(deny) = 0
    count(applied_patches) = 0
}

# Check single AZ AWSControlplane against existing G8SControlPlane
test_create_valid_awscontrolplane_checkg8ssi {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_single with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_single  with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(deny) = 0
}

# Check HA AWSControlplane against existing G8SControlPlane
test_create_valid_awscontrolplane_checkg8sha {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_ha with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_ha  with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(deny) = 0
}

# Check HA AWSControlplane against existing G8SControlPlane with different values
test_create_valid_awscontrolplane_checkg8shafail {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_ha with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes_fail

    contains(deny[_], "Number of Availability Zones different than defined in G8SControlPlane")
    count(deny) = 1
}

# Check if the order of AZs was changed
test_create_valid_awscontrolplane_update {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_update
    contains(deny[_], "Can not change the order of availability zones.")
    count(deny) = 1
}
