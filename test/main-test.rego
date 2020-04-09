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
    denyReplicas = admission.denyReplicas with input as mocks.create_valid_g8scontrolplane
    patchReplicas = admission.patchReplicas with input as mocks.create_valid_g8scontrolplane

    count(denyReplicas) = 0
    count(patchReplicas) = 1
    contains(sprintf("%s",patchReplicas[_]), "{\"op\": \"add\", \"path\": \"/spec/replicas\", \"value\": \"1\"}")

}

test_create_invalid_g8scontrolplane {
    denyReplicas = admission.denyReplicas with input as mocks.create_invalid_g8scontrolplane
    contains(denyReplicas[_], "Invalid number of Master Node replicas")
    count(denyReplicas) = 1
}

test_create_valid_awscontrolplane {
    denyAZ = admission.denyAZ with input as mocks.create_valid_awscontrolplane
    patchAZ = admission.patchAZ with input as mocks.create_valid_awscontrolplane

    count(denyAZ) = 0
    count(patchAZ) = 1
    contains(sprintf("%s",patchAZ[_]), "{\"op\": \"add\", \"path\": \"/spec/availabilityZones\", \"value\": \"eu-central-1a\"}")

}

test_create_invalid_g8scontrolplane {
    denyAZ = admission.denyAZ with input as mocks.create_invalid_awscontrolplane
    contains(denyAZ[_], "Invalid choice of Master Node Availability Zones")
    count(denyAZ) = 1
}

test_create_invalid_count_g8scontrolplane {
    denyCount = admission.denyAZcount with input as mocks.create_invalid_count_awscontrolplane
    contains(denyCount[_], "Length of list of chosen Availability Zones has to match the number of Master Node replicas")
    count(denyCount) = 1
}