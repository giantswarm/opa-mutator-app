package mocks

mocked_awscontrolplanes = {
   "default": {
      "sicp1": {
            "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
            "kind": "AWSControlPlane",
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
               "availabilityZones": [
                  "eu-central-1a",
               ],
               "instanceType": "m4.xlarge"
            }
         },
         "hacp1": {
            "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
            "kind": "AWSControlPlane",
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
               "availabilityZones": [
                  "eu-central-1a",
                  "eu-central-1b",
                  "eu-central-1c"
               ],
               "instanceType": "m4.xlarge"
            }
         }
   }
}

mocked_awscontrolplanes_fail = {
   "default": {
      "hacp1": {
         "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
         "kind": "AWSControlPlane",
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
            "availabilityZones": [
               "eu-central-1a",
            ],
            "instanceType": "m4.xlarge"
         }
      }
   }
}

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
          "labels": {
            "giantswarm.io/cluster": "ier2s"
          },
          "creationTimestamp": null,
          "name": "ier2s"
        },
        "spec": {
          "availabilityZones": [
            "bad-name",
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

create_duplicate_awscontrolplane = {
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
           "labels": {
             "giantswarm.io/cluster": "ier2s"
           },
           "creationTimestamp": null,
           "name": "ier2s"
         },
         "spec": {
           "availabilityZones": [
             "eu-central-1a",
             "eu-central-1b",
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
           "labels": {
             "giantswarm.io/cluster": "ier2s"
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

create_valid_awscontrolplane_single = {
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
           "labels": {
             "giantswarm.io/cluster": "sicp1"
           },
           "creationTimestamp": null,
           "name": "sicp1"
         },
         "spec": {
           "availabilityZones": [
             "eu-central-1a"
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

create_valid_awscontrolplane_singlenull = {
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
         "kind": "AWSControlPlane",
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

create_valid_awscontrolplane_singlenoaz = {
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
         "kind": "AWSControlPlane",
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

create_valid_awscontrolplane_hanull = {
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
         "kind": "AWSControlPlane",
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

create_valid_awscontrolplane_ha = {
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
         "kind": "AWSControlPlane",
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
           "availabilityZones": [
             "eu-central-1a",
             "eu-central-1b",
             "eu-central-1c"
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

create_invalid_instancetype_awscontrolplane = {
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
         "kind": "AWSControlPlane",
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
           "availabilityZones": null,
           "instanceType": "bad_type"
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

create_valid_awscontrolplane_instancenull = {
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
         "kind": "AWSControlPlane",
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
           "availabilityZones": [
             "eu-central-1a",
             "eu-central-1b",
             "eu-central-1c"
           ],
           "instanceType": "",
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

create_valid_awscontrolplane_preha = {
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
         "kind": "AWSControlPlane",
         "metadata": {
           "annotations": {
             "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
           },
           "labels": {
             "release.giantswarm.io/version": "11.0.1",
             "giantswarm.io/cluster": "2pm8s",
           },
           "creationTimestamp": null,
           "name": "sicp1"
         },
         "spec": {
           "availabilityZones": null,
           "instanceType": null,
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

create_valid_awscontrolplane_update = {
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
      "name":"hacp1",
      "namespace":"default",
      "operation":"UPDATE",
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
           "labels": {
             "giantswarm.io/cluster": "hacp1"
           },
           "creationTimestamp": null,
           "name": "hacp1"
         },
         "spec": {
           "availabilityZones": [
               "eu-central-1a",
               "eu-central-1b",
               "eu-central-1c",
            ],
           "instanceType": "m4.xlarge"
         }
      },
      "oldObject":{
         "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
         "kind": "AWSControlPlane",
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
           "availabilityZones": [
               "eu-central-1c",
               "eu-central-1b",
               "eu-central-1a",
            ],
           "instanceType": "m4.xlarge"
         }
      },
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_valid_awscontrolplane_sort = {
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
         "kind": "AWSControlPlane",
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
           "availabilityZones": [
             "eu-central-1c",
             "eu-central-1b",
             "eu-central-1a"
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
