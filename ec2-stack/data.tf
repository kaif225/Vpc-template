data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["amazon"]
    
    filter {
        name = "name"
        values = []
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }


}