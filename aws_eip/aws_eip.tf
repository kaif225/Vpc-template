resource "aws_eip" "demo_eip" {
}

resource "aws_instance" "demo_instance" {
    ami = ""
    instance_type = ""
    vpc_security_group_ids = [""]
}

resource "aws_eip_association" "demo_eip_ass" {
    instance_id = aws_instance.demo_instance.id
    allocation_id = aws_eip.demo_eip.id
}


////////////////////////////// or we can directly associate it like /////////////////////////////


resource "aws_eip" "demo_eip" {
   instance = aws_instance.demo_instance.id
}

resource "aws_instance" "demo_instance" {
    ami = ""
    instance_type = ""
    vpc_security_group_ids = [""]
}

/////////////////////////////// allocating multiple eip //////////////////////////////////


resource "aws_network_interface" "multi-ip" {
  subnet_id   = "${aws_subnet.main.id}"
  private_ips = ["10.0.0.10", "10.0.0.11"]
}

resource "aws_eip" "one" {
  
  network_interface         = "${aws_network_interface.multi-ip.id}"
  associate_with_private_ip = "10.0.0.10"
}

resource "aws_eip" "two" {
  
  network_interface         = "${aws_network_interface.multi-ip.id}"
  associate_with_private_ip = "10.0.0.11"
}