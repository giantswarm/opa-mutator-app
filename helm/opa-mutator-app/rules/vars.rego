package vars

import data.functions

# Possible numbers of master nodes
validReplicas := [1, 3]

# default number of master nodes
defaultReplicas := 1

# Default master instance type
defaultInstanceType := "m5.xlarge"

# List of usable availability zones. We need to get this at runtime]
validAZs = AZs {
	env_var := functions.get_env_var("AWS_VALID_AZS")
	AZs := split(env_var, ",")
}

# List of usable instance types
validInstanceTypes = InstanceTypes {
	env_var := functions.get_env_var("AWS_VALID_INSTANCE_TYPES")
	InstanceTypes := split(env_var, ",")
}

# default number of master nodes
defaultCIDR :=  functions.get_env_var("AWS_POD_CIDR")
defaultSubnet :=  functions.get_env_var("AWS_POD_SUBNET")
