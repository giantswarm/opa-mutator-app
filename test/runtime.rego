package functions

runtime := {"TEST_ENV": "hello"}

get_env_var(name) = value {
    value = runtime[name]
}