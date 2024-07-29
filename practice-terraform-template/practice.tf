resource "tls_private_key" "terraform" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my-key" {
    key_name = "terraform-key"
    public_key = tls_private_key.terraform.public_key_openssh
}

