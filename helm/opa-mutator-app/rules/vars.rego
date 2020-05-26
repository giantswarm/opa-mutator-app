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
preHANodepools := ["11.0.1", "11.1.4", "11.2.0", "11.2.1", "11.3.0", "11.3.1"]

# Returns whether the input is a non ha release version
is_preHA_nodepool_version {
  functions.hasLabelValue[["release.giantswarm.io/version", preHANodepools[_]]]	
}

