
## Download OPA chart
helm fetch --untar stable/opa

## Added env var to opa container
```
          env:
            - name: TEST_ENV
              value: hello
```

## Install local env
helm install opa-mutate ./opa -f opa_values.yaml
helm upgrade opa-mutate ./opa -f opa_values.yaml

## Unit tests
You will need the OPA binary on your PATH

`$ make run_tests`

## Manual test rules
```
$ kubectl create cm test2
$ kubectl get cm test2 -o yaml

apiVersion: v1
kind: ConfigMap
metadata:
  annotations:
    foo: hello
  creationTimestamp: "2020-04-01T14:15:39Z"
  name: test2
  namespace: default
  resourceVersion: "36207"
  selfLink: /api/v1/namespaces/default/configmaps/test2
  uid: 208e763f-12b3-4356-accc-ea066850c8b1

```

```
$ kubectl create cm test
Error from server (You cannot name it test): admission webhook "webhook.openpolicyagent.org" denied the request: You cannot name it test
```