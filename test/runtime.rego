package functions

runtime := {"AWS_VALID_AZS": "eu-central-1a,eu-central-1b,eu-central-1c"}

get_env_var(name) = value {
    value = runtime[name]
}
