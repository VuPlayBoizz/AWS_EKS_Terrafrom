variable "vpc_id" {
    description = "The ID of the VPC"
    type = string
}

variable "public_subnet_1b_id" {
    description = "The ID of the private subnet"
    type = string
}

variable "tags" {
    description = "A map of tags to add to all resources"
    type = map(string)
}
