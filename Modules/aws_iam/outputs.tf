output "eks_cluster_role_arn" {
  description = "ARN of the IAM role for EKS Cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_worker_node_role_arn" {
  description = "ARN of the IAM role for EKS Worker Nodes"
  value       = aws_iam_role.eks_worker_node_role.arn
}