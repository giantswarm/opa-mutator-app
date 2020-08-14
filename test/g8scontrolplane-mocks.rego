package mocks

mocked_g8scontrolplanes = {
   "default": {
      "sicp1": {
            "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
            "kind": "G8sControlPlane",
            "metadata": {
               "annotations": {
                  "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
               },
               "labels": {
                  "giantswarm.io/cluster": "sicp1"
               },
               "creationTimestamp": null,
               "name": "sicp1",
               "namespace": "default"
            },
            "spec": {
               "infrastructureRef": {
                  "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
                  "kind": "AWSControlPlane",
                  "name": "sicp1",
                  "namespace": "default"
               },
               "replicas": 1,
            }
         },
         "hacp1": {
            "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
            "kind": "G8sControlPlane",
            "metadata": {
               "annotations": {
                  "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
               },
               "labels": {
                  "giantswarm.io/cluster": "hacp1"
               },
               "creationTimestamp": null,
               "name": "hacp1",
               "namespace": "default"
            },
            "spec": {
               "infrastructureRef": {
                  "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
                  "kind": "AWSControlPlane",
                  "name": "hacp1",
                  "namespace": "default"
               },
               "replicas": 3,
            }
         }
   }
}

mocked_g8scontrolplanes_fail = {
   "default": {
      "hacp1": {
         "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
         "kind": "G8sControlPlane",
         "metadata": {
            "annotations": {
               "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
            },
            "labels": {
               "giantswarm.io/cluster": "hacp1"
            },
            "creationTimestamp": null,
            "name": "hacp1",
            "namespace": "default"
         },
         "spec": {
            "infrastructureRef": {
               "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
               "kind": "AWSControlPlane",
               "name": "hacp1",
               "namespace": "default"
            },
            "replicas": 1,
         }
      }
   }
}

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
          "labels": {
            "giantswarm.io/cluster": "ier2s"
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

create_valid_g8scontrolplane_single = {
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
      "name":"sicp1",
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
          "labels": {
            "giantswarm.io/cluster": "sicp1"
          },
          "creationTimestamp": null,
          "name": "sicp1"
        },
        "spec": {
          "infrastructureRef": {
            "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
            "kind": "AWSControlPlane",
            "name": "sicp1",
            "namespace": "default"
          },
          "replicas": 1,
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

create_valid_g8scontrolplane_ha = {
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
      "name":"hacp1",
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
          "labels": {
            "giantswarm.io/cluster": "hacp1"
          },
          "creationTimestamp": null,
          "name": "hacp1"
        },
        "spec": {
          "infrastructureRef": {
            "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
            "kind": "AWSControlPlane",
            "name": "hacp1",
            "namespace": "default"
          },
          "replicas": 3,
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
