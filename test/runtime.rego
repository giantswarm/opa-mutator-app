package functions

runtime := {
    "AWS_VALID_AZS": "eu-central-1a,eu-central-1b,eu-central-1c",
    "AWS_POD_CIDR": "16",
    "AWS_POD_SUBNET" : "10.2.0.0"
}

get_env_var(name) = value {
    value = runtime[name]
}
