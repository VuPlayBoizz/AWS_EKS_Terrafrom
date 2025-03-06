resource "aws_route_table" "public_rtb" {
    vpc_id          = var.vpc_id
    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = var.internet_gateway_id
    }
    tags            = merge(var.tags, { Name = "${var.tags["Name"]}-public-rtb" })
}

resource "aws_route_table" "private_rtb" {
    vpc_id          = var.vpc_id
    route {
        cidr_block  = "0.0.0.0/0"
        nat_gateway_id  = var.nat_gateway_id
    }
    tags            = merge(var.tags, { Name = "${var.tags["Name"]}-private-rtb" })
}

resource "aws_route_table_association" "public_rtb_association" {
    count           = length(var.public_subnet_ids)
    subnet_id       = var.public_subnet_ids[count.index]
    route_table_id  = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "private_rtb_association" {
    count           = length(var.private_subnet_ids)
    subnet_id       = var.private_subnet_ids[count.index]
    route_table_id  = aws_route_table.private_rtb.id
}