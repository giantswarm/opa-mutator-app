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
