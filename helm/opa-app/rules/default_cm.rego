package admission

import data.functions

deny[msg] {
    functions.is_create_or_update
    input.request.kind.kind = "ConfigMap"
    input.request.name = "test_bad"
    msg = "You cannot name it test_bad"
}

patch["default_az"] = mutation {
    functions.is_create_or_update
    input.request.kind.kind = "ConfigMap"
    mutation := [
        {"op": "add", "path": "/metadata/annotations/foo", "value": functions.get_env_var("TEST_ENV")},
    ]
}