resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "myVpc"
    }
}

resource "aws_internet_gateway" "demo_ig" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "demo-ig"
    }
}


resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public1_cb
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
    tags = {
        Name = "public-subnet1"
    }
}

resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public2_cb
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
    tags = {
        Name = "public-subnet2"
    }
}

resource "aws_subnet" "private_subnet1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private1_cb
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
    tags = {
        Name = "private-subnet1"
    }
}

resource "aws_subnet" "private_subnet2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private2_cb
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
    tags = {
        Name = "private-subnet2"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo_ig.id
    }
    tags = {
        Name = "public-rt"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = aws_vpc.my_vpc.cidr_block
        gateway_id = "local"
    }
    tags = {
        Name = "private-rt"
    }
}

resource "aws_route_table_association" "private1_rta" {
    subnet_id = aws_subnet.private_subnet1.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private2_rta" {
    subnet_id = aws_subnet.private_subnet2.id
    route_table_id = aws_route_table.private_rt.id
}


resource "aws_route_table_association" "public1_rta" {
    subnet_id = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2_rta" {
    subnet_id = aws_subnet.public_subnet2.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "private_sg" {
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.my_vpc.cidr_block]
    }
    tags = {
        Name = "private-sg"
    }
}

resource "aws_security_group" "public_sg" {
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "public-sg"
    }
}

resource "aws_instance" "public-instance" {
    subnet_id = aws_subnet.public_subnet1.id
    instance_type = var.instance-type
    count = length(var.instance)
    vpc_security_group_ids = [aws_security_group.public_sg.id]
    ami = var.ami
    tags = {
        Name = var.instance[count.index]
    }
}

