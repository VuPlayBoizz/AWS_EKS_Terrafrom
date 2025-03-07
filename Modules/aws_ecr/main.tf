resource "aws_ecr_repository" "aws_ecr" {
    name                    = var.repository_name
    image_tag_mutability    = "MUTABLE"

    encryption_configuration {
        encryption_type = "AES256"
    }
    image_scanning_configuration {
        scan_on_push = true
    }
    tags                    = var.tags
}