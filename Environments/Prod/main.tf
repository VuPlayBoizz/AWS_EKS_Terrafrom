provider "aws" {
  region = var.aws_region
}

module "aws_vpc" {   
    source                  = "../../Modules/aws_networking/01_aws_vpc"
    cidr_block              = var.cidr_block
    enable_dns_hostnames    = var.enable_dns_hostnames
    enable_dns_support      = var.enable_dns_support
    tags                    = var.tags
}

module "aws-subnet-1a" {
    source                      = "../../Modules/aws_networking/02_aws_subnet"
    vpc_id                      = module.aws_vpc.vpc_id
    public_subnet_cidr_block    = var.public_subnet_cidr_block[0]
    private_subnet_cidr_block   = var.private_subnet_cidr_block[0]
    availability_zone           = var.availability_zone[0]
    tags                        = var.tags
}

module "aws-subnet-1b" {
    source                      = "../../Modules/aws_networking/02_aws_subnet"
    vpc_id                      = module.aws_vpc.vpc_id
    public_subnet_cidr_block    = var.public_subnet_cidr_block[1]
    private_subnet_cidr_block   = var.private_subnet_cidr_block[1]
    availability_zone           = var.availability_zone[1]
    tags                        = var.tags
}

module "aws-igw" {
    source      = "../../Modules/aws_networking/03_aws_igw"
    vpc_id      = module.aws_vpc.vpc_id
    tags        = var.tags
}

module "aws-nat" {
    source              = "../../Modules/aws_networking/04_aws_nat"
    vpc_id              = module.aws_vpc.vpc_id
    public_subnet_1b_id = module.aws-subnet-1b.public_subnet_id
    tags                = var.tags
}

module "vpc-route-table" {
    source              = "../../Modules/aws_networking/05_aws_route_tables"
    vpc_id              = module.aws_vpc.vpc_id
    internet_gateway_id = module.aws-igw.internet_gateway_id
    nat_gateway_id      = module.aws-nat.nat_gateway_id
    public_subnet_ids   = [module.aws-subnet-1a.public_subnet_id, module.aws-subnet-1b.public_subnet_id]  
    private_subnet_ids  = [module.aws-subnet-1a.private_subnet_id, module.aws-subnet-1b.private_subnet_id]
    tags                = var.tags
}

module "prefix_list" {
    source              = "../../Modules/aws_networking/06_aws_prefix_list"
    eks_vpc_cidr        = var.eks_vpc_cidr
    jenkins_vpc_cidr    = var.jenkins_vpc_cidr
    ec2_vpc_cidr        = var.ec2_vpc_cidr
    My_computer_ip      = var.My_computer_ip
}

module "aws-security-group" {
    source                      = "../../Modules/aws_networking/07_aws_security_groups"
    cluster_name                = var.cluster_name
    eks_cluster_cidr_blocks     = var.cidr_block
    vpc_id                      = module.aws_vpc.vpc_id
    My_computer_ip              = var.My_computer_ip
    prefix_list_ids             = module.prefix_list.eks_prefix_list_id
    tags                        = var.tags 
}

module "iam-roles" {
    source = "../../Modules/aws_iam"
    cluster_role_name            = var.cluster_role_name
    cluster_role_policy_arns     = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
        "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    ]
    worker_node_role_name        = var.worker_node_role_name
    worker_node_role_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    ]
}

module "key-pair" {
    source      = "../../Modules/aws_ec2/01_aws_key_pair"
    key_name    = var.key_name
    environment = var.environment
}

module "jump-server" {
    source                      = "../../Modules/aws_ec2/02_aws_ec2_instance"
    instance_type               = var.instance_type
    key_name                    = module.key-pair.key_name
    subnet_id                   = module.aws-subnet-1a.public_subnet_id
    security_groups_id          = [module.aws-security-group.public_sg_id]
    associate_public_ip_address = true
    tags                        = var.tags
}

module "eks-cluster" {
    source = "../../Modules/aws_eks/01_eks_cluster"
    cluster_name            = var.cluster_name
    kubernetes_version      = var.kubernetes_version
    eks_cluster_role_arn    = module.iam-roles.eks_cluster_role_arn
    private_subnet_ids      = [module.aws-subnet-1a.private_subnet_id, module.aws-subnet-1b.private_subnet_id]
    control_plane_sg_id     = module.aws-security-group.control_plane_sg_id
    tags                    = var.tags
}

module "eks-worker-node" {
    source = "../../Modules/aws_eks/02_eks_worker_node"
    cluster_name                = var.cluster_name
    node_group_name             = var.node_group_name
    eks_worker_node_role_arn    = module.iam-roles.eks_worker_node_role_arn
    private_subnet_ids          = [module.aws-subnet-1a.private_subnet_id, module.aws-subnet-1b.private_subnet_id]
    instance_types              = var.instance_types[1]
    ami_type                    = var.ami_type
    disk_size                   = var.disk_size
    desired_size                = var.desired_size
    min_size                    = var.min_size
    max_size                    = var.max_size
    max_unavailable             = var.max_unavailable
    ec2_ssh_key                 = module.key-pair.key_name
    worker_node_sg_id           = module.aws-security-group.worker_node_sg_id
    depends_on                  = [module.eks-cluster]
}

module "ebs-csi-driver" {
    source = "../../Modules/aws_eks/03_eks_addons"
    cluster_name = var.cluster_name
    depends_on = [module.eks-cluster,
                  module.eks-worker-node]
}

module "aws_ecr" {
    source = "../../Modules/aws_ecr"
    repository_name = "nguyenbavu"
    tags = var.tags
}