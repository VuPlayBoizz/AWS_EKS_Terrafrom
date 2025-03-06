variable "vpc_id" {
    description = "The VPC ID"
    type        = string
}

variable "internet_gateway_id" {
    description = "The Internet Gateway ID"
    type        = string
}

variable "nat_gateway_id" {
    description = "The NAT Gateway ID"
    type        = string
}

variable "public_subnet_ids" {
    description = "The Public Subnet ID"
    type        = list(string)
}

variable "private_subnet_ids" {
    description = "The Private Subnet ID"
    type        = list(string)
}

variable "tags" {
    description = "The tags to apply to the resources"
    type        = map(string)  
}