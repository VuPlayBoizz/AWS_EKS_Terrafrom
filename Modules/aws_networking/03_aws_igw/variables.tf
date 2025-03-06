variable "vpc_id" {
    description = "The VPC ID to attach the Internet Gateway to"
    type        = string
}
variable "tags" {
    description = "A map of tags to add to the Internet Gateway"
    type        = map(string)
}