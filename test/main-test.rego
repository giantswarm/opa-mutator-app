package test

import data.admission
import data.functions
import data.mocks

test_default_response {
    count(admission.deny) = 0
    count(admission.patch) = 0
}

test_create_valid_configmap {
    deny = admission.deny with input as mocks.create_valid_configmap
    applied_patches = admission.patch with input as mocks.create_valid_configmap

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/metadata/annotations/foo\", \"value\": \"hello\"}")
}

test_create_invalid_configmap {
    deny = admission.deny with input as mocks.create_invalid_configmap
    contains(deny[_], "You cannot name it test_bad")
    count(deny) = 1
}

test_create_valid_g8scontrolplane {
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/replicas\", \"value\": 1}")
}

test_create_invalid_g8scontrolplane {
    deny = admission.deny with input as mocks.create_invalid_g8scontrolplane

    contains(deny[_], "Invalid number of Master Node replicas")
    count(deny) = 1
}

test_create_invalid_awscontrolplane {
    deny = admission.deny with input as mocks.create_invalid_awscontrolplane
    contains(deny[_], "Invalid choice of Master Node Availability Zones")
    count(deny) = 1
}

test_create_invalid_count_awscontrolplane {
    deny = admission.deny with input as mocks.create_invalid_count_awscontrolplane
    contains(deny[_], "Length of list of chosen Availability Zones has to match the number of Master Node replicas")
    count(deny) = 1
}


test_create_valid_awscontrolplane {
    deny = admission.deny with input as mocks.create_valid_awscontrolplane
    applied_patches = admission.patch with input as mocks.create_valid_awscontrolplane

    count(deny) = 0
    count(applied_patches) = 1
    #contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/availabilityZones\", \"value\": \"eu-central-1a\"}")

}
