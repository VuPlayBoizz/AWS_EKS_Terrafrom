variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "eks_worker_node_role_arn" {
  description = "The ARN of the IAM role to assign to the worker node group"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to launch the worker nodes"
  type        = list(string)
}

variable "instance_types" {
  description = "List of instance types for the worker nodes"
  type        = string
}

variable "ami_type" {
  description = "AMI type for the worker nodes (e.g., AL2_x86_64 or AL2_ARM_64)"
  type        = string
}

variable "disk_size" {
  description = "Disk size in GB for the worker nodes"
  type        = number
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "max_unavailable" {
  description = "Maximum number of nodes that can be unavailable during an update"
  type        = number
}

variable "ec2_ssh_key" {
  description = "SSH key to allow access to the EC2 instances"
  type        = string
}

variable "worker_node_sg_id" {
  description = "ID of the security group to attach to the worker nodes"
  type        = string
}

