data "aws_ami" "ubuntu_ami" {
    most_recent = true
    owners      = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }
}

resource "aws_instance" "ec2_instance" {
    ami                         = data.aws_ami.ubuntu_ami.id
    instance_type               = var.instance_type
    key_name                    = var.key_name
    subnet_id                   = var.subnet_id
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = var.security_groups_id
    root_block_device {
        volume_size = 30
        volume_type = "gp3"
    }
    tags                        = var.tags
}