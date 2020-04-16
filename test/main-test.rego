package test

import data.admission
import data.functions
import data.mocks

test_create_valid_g8scontrolplanenull {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_singlenull
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_singlenull

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/replicas\", \"value\": 1}")
}

test_create_valid_g8scontrolplanehanull {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_hanull  with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_hanull  with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/replicas\", \"value\": 3}")
}

test_create_valid_g8scontrolplane {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_single
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_single

    count(deny) = 0
    count(applied_patches) = 0
}

test_create_invalid_g8scontrolplane {
    deny = admission.deny with input as mocks.create_invalid_g8scontrolplane

    contains(deny[_], "Invalid number of Master Node replicas")
    count(deny) = 1
}

test_create_valid_g8scontrolplane_checkawssi {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_single with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes
    count(deny) = 0
}

test_create_valid_g8scontrolplane_checkawssinull {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_singlenull with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes
    count(deny) = 0
}

test_create_valid_g8scontrolplane_checkawsha {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_ha with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes
    count(deny) = 0
}

test_create_valid_g8scontrolplane_checkawshafail {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_ha with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes_fail
    contains(deny[_], "Number of Availability Zones different than defined in AWSControlPlane")
    count(deny) = 1
}

test_create_invalid_awscontrolplane {
    deny = admission.deny with input as mocks.create_invalid_awscontrolplane
    contains(deny[_], "Invalid choice of Master Node Availability Zones")
    count(deny) = 1
}

test_create_invalid_count_awscontrolplane {
    deny = admission.deny with input as mocks.create_invalid_count_awscontrolplane
    contains(deny[_], "Invalid number of Availability Zones")
    count(deny) = 1
}

test_create_valid_awscontrolplane {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_single
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_single

    count(deny) = 0
    count(applied_patches) = 0
}

test_create_valid_awscontrolplanenull {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_singlenull
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_singlenull

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/availabilityZones\", \"value\": [\"eu-central-1a\"]}")
}

test_create_valid_awscontrolplanehanull {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_hanull  with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane_hanull  with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/availabilityZones\", \"value\": [\"eu-central-1a\", \"eu-central-1b\", \"eu-central-1c\"]}")
}

test_create_valid_awscontrolplane_checkg8ssi {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_single with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(deny) = 0
}

test_create_valid_awscontrolplane_checkg8ssinull {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_singlenull with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(deny) = 0
}

test_create_valid_awscontrolplane_checkg8sha {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_ha with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes

    count(deny) = 0
}

test_create_valid_awscontrolplane_checkg8shafail {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane_ha with data.kubernetes.g8scontrolplanes as mocks.mocked_g8scontrolplanes_fail

    contains(deny[_], "Number of Availability Zones different than defined in G8SControlPlane")
    count(deny) = 1
}