package vars

# Possible numbers of master nodes
validReplicas := [1, 3]

# default number of master nodes
defaultReplicas := 1

# List of usable availability zones. We need to get this at runtime]
validAZs := functions.get_env_var(VALID_AZS)
