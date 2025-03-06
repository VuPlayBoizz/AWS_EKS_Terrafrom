variable "cluster_role_name" {
  description = "Name of the IAM role for EKS Cluster"
  type        = string
}

variable "cluster_role_policy_arns" {
  description = "List of policy ARNs to attach to the EKS Cluster IAM role"
  type        = list(string)
}

variable "worker_node_role_name" {
  description = "Name of the IAM role for EKS Worker Nodes"
  type        = string
}

variable "worker_node_role_policy_arns" {
  description = "List of policy ARNs to attach to the EKS Worker Node IAM role"
  type        = list(string)
}
