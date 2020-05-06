package system

# info from https://github.com/teq0/opa-k8s-admission/blob/master/rego/core.rego

import data.admission

main = {
    "apiVersion": "admission.k8s.io/v1beta1",
    "kind": "AdmissionReview",
    "response": response,
}

default response = {"allowed": true}

# non-patch response
response = x {
    count(admission.deny) > 0
    reason = concat(", ", admission.deny)
    reason != ""

    x := {
    "allowed": false,
    "status": {"reason": reason},
    }
}

# patch response
response = x {
    count(admission.patch) > 0
    count(admission.deny) == 0

    # if there are missing leaves e.g. trying to add a label to something that doesn't
    # yet have any, we need to create the leaf nodes as well
    fullPatches := ensure_parent_paths_exist(cast_array({xw | xw := admission.patch[_][_]}))

    x := {
    "allowed": true,
    "patchType": "JSONPatch",
    "patch": base64.encode(json.marshal(fullPatches)),
    }
}

# Given array of JSON patches create and prepend new patches that create missing paths.
#   CAUTION: Implementation only creates leaves.
ensure_parent_paths_exist(patches) = result {
    paths := {p.path | p := patches[_]}
    newpatches := {make_path(prefix_array) |
    paths[path]
    full_length := count(path)
    path_array := split(path, "/")
    last_element_length := count(path_array[minus(count(path_array), 1)])

    # this assumes paths starts with '/'
    prefix_path := substring(path, 1, (full_length - last_element_length) - 2)
    trace(sprintf("[ensure_parent_paths_exist] prefix_path = %s", [prefix_path]))
    prefix_array := split(prefix_path, "/")
    not input_path_exists(prefix_array) with input as input.request.object
    }

    result := array.concat(cast_array(newpatches), patches)

    trace(sprintf("[ensure_parent_paths_exist] paths = %s", [paths]))
    trace(sprintf("[ensure_parent_paths_exist] newpatches = %s", [newpatches]))
    trace(sprintf("[ensure_parent_paths_exist] result = %s", [result]))
}

# Create the JSON patch to ensure the @path_array exists
make_path(path_array) = result {
    # Need a slice of the path_array with all but the last element.
    #   No way to do that with arrays, but we can do it with strings.
    path_str := concat("/", array.concat([""], path_array))
    trace(sprintf("[make_path] path_array = %s", [path_array]))
    trace(sprintf("[make_path] path_str = %s", [path_str]))

    result = {
    "op": "add",
    "path": path_str,
    "value": {},
    }
}

# Check that the given @path exists as part of the input object.
input_path_exists(path) {
    trace(sprintf("[input_path_exists] input = %s", [input]))
    trace(sprintf("[input_path_exists] path = %s", [path]))
    walk(input, [path, walkval])
    trace(sprintf("[input_path_exists] walk = %s", [walkval]))
    walk(input, [path, _])
}
