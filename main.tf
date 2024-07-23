resource 'aws_ec2' 'myec2' {
    instance_type = var.instance-type
    ami = ''
    count = 3
    Tags = {
        Name = var.instances[count.index]
    }
}

resource "aws_security_group" "my_sg" {
   name = "demo-sg"
   ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
   }
   Tags = {
    Name = "demo-sg"
   }

}

resource 'aws_ec2' 'myec2' {
    instance_type = var.instance-type
    ami = ''
    vpc_security_group_id = [aws_security_group.my_sg.id]
    count = length(var.instances)
    Tags = {
        Name = var.instances[count.index]
    }
}