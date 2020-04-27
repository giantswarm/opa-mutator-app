package vars

import data.functions

# Possible numbers of master nodes
validReplicas := [1, 3]

# default number of master nodes
defaultReplicas := 1

# List of usable availability zones. We need to get this at runtime]
validAZs = AZs {
	env_var := functions.get_env_var("VALID_AZS")
	AZs := split(env_var, ",")
}
