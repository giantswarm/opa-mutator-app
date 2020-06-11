package functions

is_create_or_update { is_create }

is_create_or_update { is_update }

is_create { input.request.operation == "CREATE" }

is_update { input.request.operation == "UPDATE" }

is_null_or_empty_attribute(object, attribute){
  not object[attribute]
}

is_null_or_empty_attribute(object, attribute){
  object[attribute]
  is_null_or_empty(object[attribute])
}

is_null_or_empty(value) {
  is_null(value)
}

is_null_or_empty(value) {
  is_string(value)
  count(value) == 0
}

is_null_or_empty(value) {
  is_array(value)
  count(value) == 0
}

is_defined(value) {
  is_string(value)
  count(value) > 0
}

is_defined(value) {
  is_array(value)
  count(value) > 0
}

is_defined(value) {
  is_number(value)
}

hasLabels { input.request.object.metadata.labels }

hasLabel[label] {
  hasLabels
  input.request.object.metadata.labels[label]
}

hasLabelValue[[key, val]] {
  hasLabels
  input.request.object.metadata.labels[key] = val
}

hasAnnotations {
  input.request.object.metadata.annotations
}

hasAnnotation[annotation] {
  hasAnnotations
  input.request.object.metadata.annotations[annotation]
}

hasAnnotationValue[[key, val]] {
  hasAnnotations
  input.request.object.metadata.annotations[key] = val
}

# Returns whether array_b is a subset of array_a
array_not_subset(array_a, array_b) {
  intersect := cast_set(array_a) & cast_set(array_b)
  complement := cast_set(array_b) - intersect
  count(complement) != 0
}

array_contains(array, elem) {
  array[_] = elem
}

# Returns whether the values inside the input array are all different from each other
array_not_unique(array) {
  array[i] == array[j]
  i != j
}

# Returns a pseudo random number smaller than max
random_number(max) = num {
  current_time := time.now_ns()
  num = current_time % max
}

# Returns a random value from an array
random_value(array_in) = out {
  n := random_number(count(array_in))
  out := array_in[n]
}

# Returns n values from the input array, starting at a random index.
n_shifted_values(array_in, n) = array_out {
  start := random_number(count(array_in))
  end := count(array_in)
  array_a := array.slice(array_in, start, end)
  array_b := array.slice(array_in, 0, start)
  shifted := array.concat(array_a, array_b)
  # TODO: concating the array 3 times here makes sure that it's long enough for 3
  # Masters in one AZ. However, this should be changed to something dynamic
  doubled:= array.concat(shifted, shifted)
  quadrupled:= array.concat(doubled, doubled)
  array_out := array.slice(quadrupled, 0, n)
}

add_n_values(array_in, elem, n) = array_out {
  array_in[k] != elem
  addedValues := n_shifted_values(array_in[k], n)
  array_out := array.concat(cast_array(elem),addedValues)
}

orderChanged(array_old, array_new) {
   array_old[i] == array_new[j]; array_old[i] != array_new[i]
}
