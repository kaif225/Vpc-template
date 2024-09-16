resource "aws_key_pair" "terraform-key" {
  key_name = "terraform-key"
  public_key = file("/home/kaif/ssh/id_rsa.pub")

}

resource "aws_instance" "example" {
  key_name = aws_key_pair.terraform-key.key_name
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  
  provisioner "remote-exec" {
    inline = [
      "echo Hello, World!"
    ]
    
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/kaif/.ssh/id_rsa")  
      host        = self.public_ip
    }
  }
}




