resource "aws_security_group" "control_plane_sg" {
    name        = "${var.cluster_name}-control-plane-sg"
    description = "Security group for EKS control plane communication"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.eks_cluster_cidr_blocks]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # Allow all outbound traffic
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(var.tags, { Name = "${var.cluster_name}-control-plane-sg" })
}

resource "aws_security_group" "worker_node_sg" {
    name        = "${var.cluster_name}-worker-node-sg"
    description = "Security group for EKS worker nodes"
    vpc_id      = var.vpc_id

  # Allow communication from Control Plane
    ingress {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          prefix_list_ids = [var.prefix_list_ids]
    }

    egress {
          from_port   = 0
          to_port     = 0
          protocol    = "-1" # Allow all outbound traffic
          cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(var.tags, { Name = "${var.cluster_name}-worker-node-sg" })
}

resource "aws_security_group" "public_sg" {
    vpc_id      = var.vpc_id
    description = "This is security group for public subnet"
    ingress {
        description = "Allow SSH from my computer IP"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.My_computer_ip]
    }
    ingress {
        description = "Allow HTTP from my computer IP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [var.My_computer_ip]
    }
    ingress {
        description = "Allow HTTPS from my computer IP"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [var.My_computer_ip]
    }
    egress {
        description = "Allow all traffic from 0.0.0.0/0"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(var.tags, {Name: "public_sg"})   
}