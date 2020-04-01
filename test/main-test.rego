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