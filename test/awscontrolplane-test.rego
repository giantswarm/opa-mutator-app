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

# defaulting the instance type if it is null
test_create_valid_awscontrolplane_instancenull {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_instancenull
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_instancenull

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/instanceType\", \"value\": \"m5.xlarge\"}")
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

# Patch AWS ControlPlane Single with existing G8SControlPlane
test_create_valid_awscontrolplanenull {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_singlenull
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_singlenull

    count(deny) = 0
    count(applied_patches) = 1
    # contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/availabilityZones\", \"value\": [\"eu-central-1a\"]}")
}

# Patch AWS ControlPlane HA with existing G8SControlPlane
test_create_valid_awscontrolplanehanull {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_hanull  with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_hanull  with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(deny) = 0
    count(applied_patches) = 1
    # contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/availabilityZones\", \"value\": [\"eu-central-1a\", \"eu-central-1b\", \"eu-central-1c\"]}")
}

# Check single AZ AWSControlplane against existing G8SControlPlane
test_create_valid_awscontrolplane_checkg8ssi {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_single with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_single  with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(deny) = 0
}

# Check single AZ AWSControlplane against existing G8SControlPlane with defaulting
test_create_valid_awscontrolplane_checkg8ssinull {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_singlenull with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_singlenull  with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(applied_patches) = 1
    count(deny) = 0
}

test_create_valid_awscontrolplane_checkg8ssino {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_singlenoaz with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_singlenoaz  with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(applied_patches) = 1
    count(deny) = 0
}

# Check pre HA AWSControlplane against existing AWSCluster with defaulting
test_create_valid_awscontrolplane_preha {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_preha with data.kubernetes.awsclusters as mocks.mocked_awsclusters
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_preha  with data.kubernetes.awsclusters as mocks.mocked_awsclusters

    count(applied_patches) = 2
    count(deny) = 0
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/availabilityZones\", \"value\": [\"eu-central-1c\"]}")
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/instanceType\", \"value\": \"m5.xlarge\"}")
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
