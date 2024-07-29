data "aws_ami" "ubuntu" {
    owners = ["amazon"]

    filter {
        name = "name"
        values = [""]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name = "root-device-type"
        values = ["ebs"]
    }


}