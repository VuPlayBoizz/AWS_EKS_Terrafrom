resource "aws_eks_node_group" "worker_nodes" {
    cluster_name    = var.cluster_name
    node_group_name = var.node_group_name
    node_role_arn   = var.eks_worker_node_role_arn
    subnet_ids      = var.private_subnet_ids
    instance_types  = [var.instance_types]
    ami_type        = var.ami_type
    disk_size       = var.disk_size

    scaling_config {
        desired_size    = var.desired_size
        min_size        = var.min_size
        max_size        = var.max_size
    }

    remote_access {
        ec2_ssh_key                 = var.ec2_ssh_key
        source_security_group_ids   = [var.worker_node_sg_id]
    }

    update_config {
        max_unavailable = var.max_unavailable
    }
}