package functions

runtime := {
    "AWS_VALID_AZS": "eu-central-1a,eu-central-1b,eu-central-1c",
    "AWS_VALID_INSTANCE_TYPES": "c5.xlarge,c5.2xlarge,c5.4xlarge,c5.9xlarge,c5n.4xlarge,i3.xlarge,m4.xlarge,m4.2xlarge,m4.4xlarge,m5.xlarge,m5.2xlarge,m5.4xlarge,r3.xlarge,r3.2xlarge,r3.4xlarge,r3.8xlarge,r5.xlarge,r5.2xlarge,r5.4xlarge,r5.8xlarge,r5.12xlarge,t2.xlarge,t2.2xlarge,p2.xlarge,p3.2xlarge,p3.8xlarge",
    "AWS_POD_CIDR": "16",
    "AWS_POD_SUBNET" : "10.2.0.0"
}

get_env_var(name) = value {
    value = runtime[name]
}
