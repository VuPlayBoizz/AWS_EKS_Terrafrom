resource "aws_iam_role" "eks_cluster_role" {
  name               = var.cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_assume_role_policy" {
    statement {
        actions       = ["sts:AssumeRole"]
        principals {
          type        = "Service"
          identifiers = ["eks.amazonaws.com"]
        }
    }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_attachment" {
    count      = length(var.cluster_role_policy_arns)
    role       = aws_iam_role.eks_cluster_role.name
    policy_arn = var.cluster_role_policy_arns[count.index]
}

resource "aws_iam_role" "eks_worker_node_role" {
    name               = var.worker_node_role_name
    assume_role_policy = data.aws_iam_policy_document.eks_worker_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_worker_assume_role_policy" {
    statement {
        actions       = ["sts:AssumeRole"]
        principals {
          type        = "Service"
          identifiers = ["ec2.amazonaws.com"]
        }
    }
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_role_attachment" {
    count      = length(var.worker_node_role_policy_arns)
    role       = aws_iam_role.eks_worker_node_role.name
    policy_arn = var.worker_node_role_policy_arns[count.index]
}
