variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "tags" {
    description = "A map of tags to assign to the resource"
    type        = map(string)
}