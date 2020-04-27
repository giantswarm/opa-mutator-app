package functions

is_create_or_update { is_create }

is_create_or_update { is_update }

is_create { input.request.operation == "CREATE" }

is_update { input.request.operation == "UPDATE" }

hasLabels { input.metadata.labels }

hasLabel[label] {
    hasLabels
    input.metadata.labels[label]
}

hasLabelValue[[key, val]] {
    hasLabels
    input.metadata.labels[key] = val
}

hasAnnotations {
    input.metadata.annotations
}

hasAnnotation[annotation] {
    hasAnnotations
    input.metadata.annotations[annotation]
}

hasAnnotationValue[[key, val]] {
    hasAnnotations
    input.metadata.annotations[key] = val
}

array_not_subset(array_a, array_b) {
  intersect := cast_set(array_a) & cast_set(array_b)
  complement := cast_set(array_b) - intersect
  count(complement) != 0
}

array_contains(array, elem) {
  array[_] = elem
}