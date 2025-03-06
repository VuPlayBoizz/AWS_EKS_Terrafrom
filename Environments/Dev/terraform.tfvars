// Values for the providers
region = "ap-southeast-1"

//Values for the aws_vpc module
cidr_block              = "10.0.0.0/16"
enable_dns_support      = true
enable_dns_hostnames    = true
tags = {
    Name        = "eks-vpc"
    Environment = "dev"
    Owner       = "Nguyen Ba Vu"
}

//Values for the aws_subnet module
public_subnet_cidr_block    = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr_block   = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone           = ["ap-southeast-1a", "ap-southeast-1b"]

//Values for the aws_igw module
//Values for the aws_nat module
//Values for the aws_route module
//Values for the aws_prefix_list module
eks_vpc_cidr        = "10.0.0.0/16"
jenkins_vpc_cidr    = "11.0.0.0/16"
ec2_vpc_cidr        = "12.0.0.0/16"
My_computer_ip          = "1.54.8.223/32"

//Values for the aws_security_group module
cluster_name            = "eks-cluster"

//Values for the aws_iam_roles module
cluster_role_name            = "eks-cluster-role"
worker_node_role_name        = "eks-worker-node-role"

//Values for the aws_key_pair module
key_name = "eks-key-pair"
environment = "Dev"
//Values for the aws_ec2_instance module
instance_type = "t2.medium"

//Values for the aws_eks module
kubernetes_version = "1.31"

//Values for the aws_worker_nodes module
node_group_name = "eks-worker-node-group"
instance_types  = [ "t2.medium", "t3.medium" ]
ami_type        = "AL2_x86_64"
disk_size       = 20
desired_size    = 2
min_size        = 1
max_size        = 3
max_unavailable = 1