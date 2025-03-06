variable "vpc_id" {
    description = "The VPC ID"
    type        = string
}

variable "public_subnet_cidr_block" {
    description = "The CIDR block for the public subnet"
    type        = string
}

variable "private_subnet_cidr_block" {
    description = "The CIDR block for the private subnet"
    type        = string
}
variable "availability_zone" {
    description = "The availability zone"
    type        = string
}
variable "tags" {
    description = "The tags for the resources"
    type        = map(string)
}