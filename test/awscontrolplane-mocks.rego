package mocks

create_invalid_awscontrolplane = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSControlPlane"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSControlPlane"
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
        "kind": "AWSControlPlane",
        "metadata": {
          "annotations": {
            "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
          },
          "creationTimestamp": null,
          "name": "ier2s"
        },
        "spec": {
          "availabilityZones": [
            "bad-name"
          ],
          "instanceType": "m4.xlarge"
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

create_invalid_count_awscontrolplane = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSControlPlane"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSControlPlane"
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
         "kind": "AWSControlPlane",
         "metadata": {
           "annotations": {
             "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
           },
           "creationTimestamp": null,
           "name": "ier2s"
         },
         "spec": {
           "availabilityZones": [
             "eu-central-1a",
             "eu-central-1b"
           ],
           "instanceType": "m4.xlarge"
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

create_valid_awscontrolplane = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSControlPlane"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSControlPlane"
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
         "kind": "AWSControlPlane",
         "metadata": {
           "annotations": {
             "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
           },
           "creationTimestamp": null,
           "name": "ier2s"
         },
         "spec": {
           "availabilityZones": null,
           "instanceType": "m4.xlarge"
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
