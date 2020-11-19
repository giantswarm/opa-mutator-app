[![CircleCI](https://circleci.com/gh/giantswarm/opa-mutator-app.svg?style=svg)](https://circleci.com/gh/giantswarm/opa-mutator-app)

# DEPRECATION NOTICE

Please note that we do not want to add further functionality to this repository. `opa-mutator-app` will be deprecated as soon as GS releases 11.x.x < 11.4.0 are archived and we do not create new clusters with them anymore. For validating and defaulting webhooks in AWS please use [aws-admission-controller](https://github.com/giantswarm/aws-admission-controller)

# OPA for Giant Swarm
[Open Policy Agent](https://www.openpolicyagent.org/) app running on installations to validate and mutate Giant Swarm kubernetes resources using webhooks.

![OPA](./media/opa.png)

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
## Adding unit tests for rego rules
To make sure the rules work as desired, we can add unit tests.

To test the `deny` from above:
```
test_create_invalid_awscontrolplane {
    # add a mock input that includes the attribute that should be denied by the rule
    deny = admission.deny with input as mocks.create_invalid_awscontrolplane

    # if the rule was applied, the error message should appear and one deny should be counted
    contains(deny[_], "Invalid choice of Master Node Availability Zones")
    count(deny) = 1
}
```

To test the `patch` from above:
```
test_create_valid_g8scontrolplanenull {
    # add a mock input that includes the attribute that should be patched by the rule.
    deny = admission.deny with input as mocks.create_valid_g8scontrolplane_singlenull
    applied_patches = admission.patch with input as mocks.create_valid_g8scontrolplane_singlenull

    # if the rule was applied, the default value should appear and one patch
    # as well as no deny should be counted
    count(deny) = 0
    count(applied_patches) = 1
    contains(sprintf("%s",applied_patches[_]), "{\"op\": \"add\", \"path\": \"/spec/replicas\", \"value\": 1}")
}
```

## Found a problem?
If OPA is not available in the cluster for some reason, the objects managed by OPA will not be able to be created or updated.

In order to disable OPA execute the following command and create an issue:

`$> kubectl delete mutatingwebhookconfigurations.admissionregistration.k8s.io opa-mutator-app-unique `
