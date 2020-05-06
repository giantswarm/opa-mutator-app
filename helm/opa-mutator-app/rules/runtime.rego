package functions

runtime := opa.runtime()

get_env_var(name) = value {
    value = runtime.env[name]
}