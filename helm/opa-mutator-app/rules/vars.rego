package vars

import data.functions

# Possible numbers of master nodes
validReplicas := [1, 3]

# Default number of master nodes
defaultReplicas := 3

# Default master instance type
defaultInstanceType := "m5.xlarge"

# List of usable availability zones.
validAZs = AZs {
	env_var := functions.get_env_var("AWS_VALID_AZS")
	AZs := split(env_var, ",")
}

# List of usable instance types
validInstanceTypes = InstanceTypes {
	env_var := functions.get_env_var("AWS_VALID_INSTANCE_TYPES")
	InstanceTypes := split(env_var, ",")
}

# Default Pod CIDR and Subnet
defaultCIDR :=  functions.get_env_var("AWS_POD_CIDR")
defaultSubnet :=  functions.get_env_var("AWS_POD_SUBNET")

# List of the aws-operator legacy nodepool versions that need 
# to reconcile the master attribute in the awsCluster
# TODO: put the real values here
awsOperatorLegacyNodepools := ["8.0.0", "8.2.0"]

# Returns whether the input is using a non ha aws-operator version
is_legacy_nodepool_version {
  functions.hasLabelValue[["aws-operator.giantswarm.io/version", awsOperatorLegacyNodepools[_]]]
}

