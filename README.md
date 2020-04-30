[![CircleCI](https://circleci.com/gh/giantswarm/opa-mutator-app.svg?style=svg)](https://circleci.com/gh/giantswarm/opa-mutator-app)

## Render templates local
helm template helm/opa-mutator-app -f opa_values.yaml

## Added env var to opa container
```
          env:
            - name: TEST_ENV
              value: hello
```

## Manual installation steps
First installation:
`helm install opa-mutate ./opa -f opa_values.yaml`

To upgrade rules and deployment:
`helm upgrade opa-mutate ./opa -f opa_values.yaml`

## Local unit testing
This will not interact with any kubernetes service, it can run locally. You will need the OPA binary on your PATH, download from [repo](https://github.com/open-policy-agent/opa/releases).

This command will run all tests

`$ make run_tests`

Coverage report will output coverage for files that contain `rules` string in it

`$ make run_coverage`
