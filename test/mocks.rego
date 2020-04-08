package mocks

create_invalid_configmap = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1",
         "kind":"ConfigMap"
      },
      "resource":{
         "group":"",
         "version":"v1",
         "resource":"configmaps"
      },
      "requestKind":{
         "group":"",
         "version":"v1",
         "kind":"ConfigMap"
      },
      "requestResource":{
         "group":"",
         "version":"v1",
         "resource":"configmaps"
      },
      "name":"test_bad",
      "namespace":"default",
      "operation":"CREATE",
      "userInfo":{
         "username":"kubernetes-admin",
         "groups":[
            "system:masters",
            "system:authenticated"
         ]
      },
      "object":{
         "kind":"ConfigMap",
         "apiVersion":"v1",
         "metadata":{
            "name":"test_bad",
            "creationTimestamp":null
         }
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_valid_configmap = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1",
         "kind":"ConfigMap"
      },
      "resource":{
         "group":"",
         "version":"v1",
         "resource":"configmaps"
      },
      "requestKind":{
         "group":"",
         "version":"v1",
         "kind":"ConfigMap"
      },
      "requestResource":{
         "group":"",
         "version":"v1",
         "resource":"configmaps"
      },
      "name":"test_good",
      "namespace":"default",
      "operation":"CREATE",
      "userInfo":{
         "username":"kubernetes-admin",
         "groups":[
            "system:masters",
            "system:authenticated"
         ]
      },
      "object":{
         "kind":"ConfigMap",
         "apiVersion":"v1",
         "metadata":{
            "name":"test_good",
            "creationTimestamp":null
         }
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_invalid_g8scontrolplane = {
  "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
  "kind": "G8sControlPlane",
  "metadata": {
    "annotations": {
      "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
    },
    "creationTimestamp": null,
    "name": "ier2s"
  },
  "spec": {
    "infrastructureRef": {
      "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
      "kind": "AWSControlPlane",
      "name": "ier2s",
      "namespace": "default"
    },
    "replicas": 2
  }
}

create_valid_g8scontrolplane = {
  "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
  "kind": "G8sControlPlane",
  "metadata": {
    "annotations": {
      "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
    },
    "creationTimestamp": null,
    "name": "ier2s"
  },
  "spec": {
    "infrastructureRef": {
      "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
      "kind": "AWSControlPlane",
      "name": "ier2s",
      "namespace": "default"
    },
    "replicas":
  }
}