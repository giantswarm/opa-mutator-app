package mocks

mocked_awsclusters = {
   "default": {
      "2pm8s": {
            "apiVersion": "infrastructure.giantswarm.io/v1alpha2",
            "kind": "AWSCluster",
            "metadata": {
               "annotations": {
                     "giantswarm.io/docs": "https://docs.giantswarm.io/reference/cp-k8s-api/"
                  },
               "creationTimestamp": null,
               "name": "2pm8s",
               "namespace": "default"
            },
            "spec": {
              "provider": {
                 "master": {
                    "availabilityZone": "eu-central-1c",
                    "instanceType": "m5.xlarge",
                  },
                 "pods": {
                   "cidrBlock": "10.2.0.0/16"
                 },
               }
            },
         },
   }
}

create_invalid_awscluster = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
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
         "kind": "AWSCluster",
         "metadata": {
            "labels": {
            "release.giantswarm.io/version": "11.3.1"
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "availabilityZone": "eu-central-1x",
                  "instanceType": "m5.xlarge",
               },
               "pods": {
                  "cidrBlock": "10.2.0.0/16"
               },
            }
         },
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_invalid_instancetype_awscluster = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
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
         "kind": "AWSCluster",
         "metadata": {
            "labels": {
            "release.giantswarm.io/version": "11.3.1"
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "availabilityZone": "eu-central-1a",
                  "instanceType": "bad",
               },
               "pods": {
                  "cidrBlock": "10.2.0.0/16"
               },
            }
         },
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_valid_awscluster_instancenull = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
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
         "kind": "AWSCluster",
         "metadata": {
            "labels": {
            "release.giantswarm.io/version": "11.0.1",
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "availabilityZone": "eu-central-1a",
                  "instanceType": "",
               },
               "pods": {
                  "cidrBlock": "10.2.0.0/16"
               },
            }
         },
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_valid_awscluster_noinstance = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
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
         "kind": "AWSCluster",
         "metadata": {
            "labels": {
            "release.giantswarm.io/version": "11.0.1",
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "availabilityZone": "eu-central-1a",
               },
               "pods": {
                  "cidrBlock": "10.2.0.0/16"
               },
            }
         },
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_valid_awscluster_aznull = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
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
         "kind": "AWSCluster",
         "metadata": {
            "labels": {
            "release.giantswarm.io/version": "11.0.1"
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "availabilityZone": "",
                  "instanceType": "m5.xlarge",
               },
               "pods": {
                  "cidrBlock": "10.2.0.0/16"
               },
            }
         },
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_valid_awscluster_noaz = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
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
         "kind": "AWSCluster",
         "metadata": {
            "labels": {
            "release.giantswarm.io/version": "11.0.1"
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "instanceType": "m5.xlarge",
               },
               "pods": {
                  "cidrBlock": "10.2.0.0/16"
               },
            }
         },
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_valid_awscluster_cninull = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
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
         "apiVersion": "infrastructure.giantswarm.io/v1",
         "kind": "AWSCluster",
         "metadata": {
            "labels": {
            "release.giantswarm.io/version": "11.0.1"
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "availabilityZone": "eu-central-1b",
                  "instanceType": "m5.xlarge",
               },
               "pods": {
                  "cidrBlock": "",
               },
            }
         },
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}

create_valid_awscluster_nocni = {
   "kind":"AdmissionReview",
   "apiVersion":"admission.k8s.io/v1beta1",
   "request":{
      "uid":"d06e33d2-d618-4787-8a68-2b005f063169",
      "kind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
      },
      "resource":{
         "group":"",
         "version":"v1alpha2",
         "resource":"infrastructure.giantswarm.io"
      },
      "requestKind":{
         "group":"",
         "version":"v1alpha2",
         "kind":"AWSCluster"
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
         "apiVersion": "infrastructure.giantswarm.io/v1",
         "kind": "AWSCluster",
         "metadata": {
            "labels": {
            "release.giantswarm.io/version": "11.0.1"
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "availabilityZone": "eu-central-1b",
                  "instanceType": "m5.xlarge",
               },
               "pods": {
               },
            }
         },
      },
      "oldObject":null,
      "dryRun":false,
      "options":{
         "kind":"CreateOptions",
         "apiVersion":"meta.k8s.io/v1"
      }
   }
}
