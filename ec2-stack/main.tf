resource "aws_ec2" "myec2" {
    instance_type = var.instance-type
    ami = ""
    count = 3
    tags = {
        Name = var.instances[count.index]
    }
}

resource "aws_security_group" "my_sg" {
   name = "demo-sg"
   ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
   tags = {
    Name = "demo-sg"
   }

}

resource "aws_ec2" "myec2" {
    instance_type = var.instance-type
    ami = data.aws_ami.ubuntu.id
    vpc_security_group_id = [aws_security_group.my_sg.id]
    count = length(var.instances)
    tags = {
        Name = var.instances[count.index]
    }
    user_data = file("${path.module}/script.sh")

}