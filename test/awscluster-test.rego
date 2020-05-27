package test

import data.admission
import data.functions
import data.mocks

# a non valid AZ name
test_create_invalid_awscluster {
    deny = admission.deny with input as mocks.create_invalid_awscluster
    contains(deny[_], "Invalid choice of Master Node Availability Zone")
    count(deny) = 1
}

# a non valid instance type
test_create_invalid_instancetype_awscluster {
    deny = admission.deny with input as mocks.create_invalid_instancetype_awscluster
    contains(deny[_], "Invalid choice of Master Node Instance Type")
    count(deny) = 1
}

# defaulting the instance type if it is empty
test_create_valid_awscluster_instancenull {
    deny = admission.deny with input as mocks.create_valid_awscluster_instancenull
    applied_patches = admission.patch with input as mocks.create_valid_awscluster_instancenull

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/provider/master/instanceType\", \"value\": \"m5.xlarge\"}")
}

# defaulting the instance type if it is empty
test_create_valid_awscluster_noinstance {
    deny = admission.deny with input as mocks.create_valid_awscluster_noinstance
    applied_patches = admission.patch with input as mocks.create_valid_awscluster_noinstance

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/provider/master/instanceType\", \"value\": \"m5.xlarge\"}")
}


# defaulting the AZ if it is null
test_create_valid_awscluster_aznull {
    deny = admission.deny with input as mocks.create_valid_awscluster_aznull
    applied_patches = admission.patch with input as mocks.create_valid_awscluster_aznull

    count(deny) = 0
    count(applied_patches) = 1
    # contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/provider/master/availabilityZone\", \"value\": \"eu-central-1a\"}")
}


# defaulting the AZ if it is null
test_create_awsclusters_noaz {
    deny = admission.deny with input as mocks.create_valid_awscluster_noaz
    applied_patches = admission.patch with input as mocks.create_valid_awscluster_noaz

    count(deny) = 0
    count(applied_patches) = 1
    # contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/provider/master/availabilityZone\", \"value\": \"eu-central-1a\"}")
}

test_create_valid_awscluster_cninull {
    deny = admission.deny with input as mocks.create_valid_awscluster_cninull
    applied_patches = admission.patch with input as mocks.create_valid_awscluster_cninull

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/provider/pods/cidrBlock\", \"value\": \"10.2.0.0/16\"}")
}

test_create_valid_awscluster_nocni {
    deny = admission.deny with input as mocks.create_valid_awscluster_nocni
    applied_patches = admission.patch with input as mocks.create_valid_awscluster_nocni

    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/provider/pods/cidrBlock\", \"value\": \"10.2.0.0/16\"}")
}
