package mocks

create_invalid_g8scontrolplane = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"G8sControlPlane"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"G8sControlPlane"
      },
      "requestResource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
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
          "replicas": 2,
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

create_valid_g8scontrolplane = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"G8sControlPlane"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"G8sControlPlane"
      },
      "requestResource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
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
          "replicas": null,
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
