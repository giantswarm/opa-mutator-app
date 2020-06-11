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

# Latest pre-HA version of Giant Swarm
# to reconcile the master attribute in the awsCluster
lastPreHAVersion := "11.3.9"

# Returns whether the input is a non ha release version
is_preHA_nodepool_version {
    currentv = input.request.object.metadata.labels["release.giantswarm.io/version"]
	  currentv_clean = split(currentv, "-")[0]
    currentv_split := split(currentv_clean, ".")
    lastPreHAVersion_split := split(lastPreHAVersion, ".")

  	to_number(currentv_split[0]) <= to_number(lastPreHAVersion_split[0])
  	to_number(currentv_split[1]) <= to_number(lastPreHAVersion_split[1])
  	to_number(currentv_split[2]) <= to_number(lastPreHAVersion_split[2])
}
