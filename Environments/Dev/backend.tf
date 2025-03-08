terraform {
  backend "s3" {
    bucket         = "terraformbucket1902"
    key            = "networking/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
