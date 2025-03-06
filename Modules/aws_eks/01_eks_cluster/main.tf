resource "aws_eks_cluster" "eks_cluster" {
    name        = var.cluster_name
    role_arn    = var.eks_cluster_role_arn
    version     = var.kubernetes_version

    vpc_config {
        endpoint_private_access     = true
        endpoint_public_access      = true
        subnet_ids                  = var.private_subnet_ids
        security_group_ids          = [var.control_plane_sg_id]
    }

    access_config {
        authentication_mode = "API_AND_CONFIG_MAP"
        bootstrap_cluster_creator_admin_permissions = true
    }
    tags = merge(var.tags, {Name = "${var.tags["Name"]}-cluster-demo"})
}
