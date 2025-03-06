variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "enable_dns_support" {
    description = "A boolean flag to enable/disable DNS support in the VPC"
    type        = bool
}

variable "enable_dns_hostnames" {
    description = "A boolean flag to enable/disable DNS hostnames in the VPC"
    type        = bool
}

variable "tags" {
    description = "A map of tags to assign to the resource"
    type        = map(string)
}