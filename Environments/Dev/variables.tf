// Define the variables in Provider block
variable "region" {
    description = "The region where resources will be created"
    type        = string
}

// Define the variables in aws_vpc module
variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}
variable "enable_dns_hostnames" {
    description = "A boolean flag to enable/disable DNS hostnames in the VPC"
    type        = bool
}
variable "enable_dns_support" {
    description = "A boolean flag to enable/disable DNS support in the VPC"
    type        = bool
}
variable "tags" {
    description = "A map of tags to assign to the resources"
    type        = map(string)
}

// Define the variables in aws_subnet module
variable "public_subnet_cidr_block" {
    description = "The CIDR block for the public subnet"
    type        = list(string)
}
variable "private_subnet_cidr_block" {
    description = "The CIDR block for the private subnet"
    type        = list(string)
}
variable "availability_zone" {
    description = "The availability zone"
    type        = list(string)
}

// Define the variables in aws_igw module
// Define the variables in aws_nat module
// Define the variables in aws_route_tables module
// Define the variables in aws_prefix_list module
variable "eks_vpc_cidr" {
    description = "The CIDR block for the EKS VPC"
    type        = string
}
variable "jenkins_vpc_cidr" {
    description = "The CIDR block for the Jenkins VPC"
    type        = string
}
variable "ec2_vpc_cidr" {
    description = "The CIDR block for the ec2 VPC"
    type        = string
}
variable "My_computer_ip" {
    description = "The IP address of the computer"
    type        = string
}

// Define the variables in aws_security_group module
variable "cluster_name" {
    description = "The name of the cluster"
    type        = string
}

// Define the variables in aws_iam_roles module
variable "cluster_role_name" {
    description = "The name of the IAM role"
    type        = string
}
variable "worker_node_role_name" {
    description = "The name of the IAM role"
    type        = string
}

// Define the variables in aws_key_pair module
variable "key_name" {
    description = "The name of the key pair"
    type        = string
}
variable "environment" {
    type = string
}
// Define the variables in aws_ec2_instance module
variable "instance_type" {
    type = string
}

// Define the variables in aws_eks module
variable "kubernetes_version" {
    description = "The version of Kubernetes"
    type        = string
}

//Define the variables in aws_worker_node module
variable "node_group_name" {
    description = "The name of the node group"
    type        = string
  
}
variable "instance_types" {
    description = "The instance type"
    type        = list(string)
}
variable "ami_type" {
    description = "The type of AMI"
    type        = string
}
variable "disk_size" {
    description = "The size of the disk"
    type        = number
}
variable "desired_size" {
    description = "The desired number of worker nodes"
    type        = number
}
variable "min_size" {
    description = "The minimum number of worker nodes"
    type        = number
}
variable "max_size" {
    description = "The maximum number of worker nodes"
    type        = number
}
variable "max_unavailable" {
    description = "The maximum number of unavailable worker nodes"
    type        = number
}
