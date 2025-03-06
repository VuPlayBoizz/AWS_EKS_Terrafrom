resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key_file" {
  filename = "${path.root}/${var.key_name}.pem"
  content  = tls_private_key.key.private_key_pem
}