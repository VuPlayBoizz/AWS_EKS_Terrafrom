variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
}

variable "eks_cluster_role_arn" {
    description = "The ARN of the IAM role that provides permissions for the EKS cluster"
    type        = string
}

variable "kubernetes_version" {
    description = "The Kubernetes version for the EKS cluster"
    type        = string
}

variable "private_subnet_ids" {
    description = "The IDs of the private subnets"
    type        = list(string)
}

variable "control_plane_sg_id" {
    description = "The ID of the security group for the EKS control plane"
    type        = string
  
}

variable "tags" {
    description = "A map of tags to add to all resources"
    type        = map(string)
}
