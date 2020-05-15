package mocks

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
                  "cidrBlock": ""
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
                  "cidrBlock": ""
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
            "release.giantswarm.io/version": "11.3.1"
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "availabilityZone": "eu-central-1a",
                  "instanceType": null,
               },
               "pods": {
                  "cidrBlock": ""
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
            "release.giantswarm.io/version": "11.3.1"
            }
         },
         "spec": {
            "provider": {
               "master": {
                  "availabilityZone": null,
                  "instanceType": "m5.xlarge",
               },
               "pods": {
                  "cidrBlock": ""
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

