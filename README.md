[![CircleCI](https://circleci.com/gh/giantswarm/opa-mutator-app.svg?style=svg)](https://circleci.com/gh/giantswarm/opa-mutator-app)

# opa-mutator-app
[open policy agent](https://www.openpolicyagent.org/) app running on installations to validate and default kubernetes custom resources using webhooks.

## Rendering the helm template locally
`helm template helm/opa-mutator-app -f opa_values.yaml`

## Manual installation steps
First installation:
`helm install opa-mutate ./opa -f opa_values.yaml`

To upgrade rules and deployment:
`helm upgrade opa-mutate ./opa -f opa_values.yaml`

## Local unit testing
This will not interact with any kubernetes service, it can run locally.
You will need the OPA binary on your PATH, download from [repo](https://github.com/open-policy-agent/opa/releases).

This command will run all tests

`$ make run_tests`

Coverage report will output coverage for files that contain `rules` string in it

`$ make run_coverage`

## Adding environment variables to the opa container
In `deployment.yaml` file:
```
          env:
            - name: TEST_ENV
              value: hello
```

## Rules for defaulting and validation
The body of a rule written in `rego` format is made up of logical statements. 
If they all evaluate to `true` for an input, the rule will be applied. 

To validate a field in a custom resource, we can define which inputs have to be denied.
```
deny[msg] {
    # type of request
    functions.is_create_or_update

    # type of custom resource
    input.request.kind.kind = "AWSControlPlane"

    # defining the input that should be denied
    is_array(input.request.object.spec.availabilityZones)
    functions.array_not_subset(vars.validAZs, input.request.object.spec.availabilityZones)

    # reason for denial as an error message
    msg = "Invalid choice of Master Node Availability Zones"
}
```

To default a field in a custom resource, we can define which inputs have to be patched
plus the patch to be used for defaulting.
```
patch["default_replicas"] = mutation {
    # type of request
    functions.is_create_or_update

    # type of custom resource
    input.request.kind.kind = "G8sControlPlane"

    # defining the input that should be defaulted
    is_null(input.request.object.spec.replicas)
    not data.kubernetes.awscontrolplanes[input.request.namespace][input.request.name]

    # defining json patch for the defaulting
    mutation := [
        {"op": "add", "path": "/spec/replicas", "value": vars.defaultReplicas},
    ]
}
```
