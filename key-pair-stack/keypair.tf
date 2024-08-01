resource "aws_key_pair" "terraform-key" {
  key_name = "terraform-key"
  public_key = file("/home/kaif/ssh/id_rsa.pub")

}

// in the first approach we just use the already existing private nad public keypair that is present locally that we can use to connect to the instance


// in the below approach we create a key-pair in aws
resource "tls_private_key" "terraform-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "terra" {
  key_name = "terraform-key"
  
  public_key = tls_private_key.terraform-key.public_key_openssh

}

output "private-key" {
    value = tls_private_key.terraform-key.private_key_pem
}