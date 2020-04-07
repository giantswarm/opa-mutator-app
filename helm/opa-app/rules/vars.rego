package vars

# Possible numbers of master nodes
validReplicas := [1, 3]

# default number of master nodes
defaultReplicas := 1

# Number of master nodes. This has to be set from the corresponding g8scontrolplane
replicas := 1

# List of usable availability zones. We need to get this at runtime
validAZs := ["eu-central-1a", "eu-central-1b", "eu-central-1c"]

# This has to contain at least $replica AZs from validAZs and 
# we need to decide how exactly defaulting should work
# (don't forget that defaultAZs can be > validAZs)
defaultAZs := ["eu-central-1a", "eu-central-1b", "eu-central-1c"] 




