package test

import data.admission
import data.functions
import data.mocks

# defaulting the replicas if they are null
test_create_valid_g8scontrolplanenull {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_singlenull
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_singlenull

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"spec/replicas\", \"value\": 1}")
}

# defaulting the replicas when the awscontrolplane already exists with single AZ
test_create_valid_g8scontrolplanesinglenull {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_singlenull  with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_singlenull  with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"spec/replicas\", \"value\": 1}")
}

# defaulting the replicas when the awscontrolplane already exists with multiple AZ
test_create_valid_g8scontrolplanehanull {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_hanull  with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_hanull  with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"spec/replicas\", \"value\": 3}")
}

# A valid number of replicas is defined (checked against vars.validReplicas)
test_create_valid_g8scontrolplane {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_single
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_single

    count(deny) = 0
    count(applied_patches) = 0
}

# A non valid number of replicas is defined (checked against vars.validReplicas)
test_create_invalid_g8scontrolplane {
    deny = admission.deny with input as mocks.create_invalid_g8scontrolplane

    contains(deny[_], "Invalid number of Master Node replicas")
    count(deny) = 1
}

# Check valid Single G8SControlPlane against existing AWSControlplane
test_create_valid_g8scontrolplane_checkawssi {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_single with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_single  with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes

    count(deny) = 0
    count(applied_patches) = 0
}

# Check valid HA G8SControlPlane against existing AWSControlplane with defaulting
test_create_valid_g8scontrolplane_checkawssinull {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_singlenull with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_singlenull  with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"spec/replicas\", \"value\": 1}")
}

# Check HA G8SControlPlane against existing AWSControlplane
test_create_valid_g8scontrolplane_checkawsha {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_ha with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_ha  with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes

    count(deny) = 0
    count(applied_patches) = 0
}

# Check HA G8SControlPlane against existing AWSControlplane with different values
test_create_valid_g8scontrolplane_checkawshafail {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_ha with data.kubernetes.awscontrolplanes as mocks.mocked_awscontrolplanes_fail
    contains(deny[_], "Number of Availability Zones different than defined in AWSControlPlane")
    count(deny) = 1
}
