resource "aws_internet_gateway" "igw" {
    vpc_id  = var.vpc_id
    tags    = merge(var.tags, {Name = "${var.tags["Name"]}-igw"})
}