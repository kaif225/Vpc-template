
// Create VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "demo-vpc"
  }
}

// Create Internet Gateway (IGW)
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo-igw"
  }
}

// Create Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.public_subnet1
  availability_zone = "us-east-1a"  // Replace with your desired availability zone
  map_public_ip_on_launch = true  // Enable auto-assign public IP addresses

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.public_subnet2
  availability_zone = "us-east-1b"  // Replace with your desired availability zone
  map_public_ip_on_launch = true  // Enable auto-assign public IP addresses

  tags = {
    Name = "public-subnet-2"
  }
}

// Create Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.private_subnet1
  availability_zone = "us-east-1a"  // Replace with your desired availability zone

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.private_subnet2
  availability_zone = "us-east-1b"  // Replace with your desired availability zone

  tags = {
    Name = "private-subnet-2"
  }
}

// Attach Internet Gateway to VPC (for public subnets)
resource "aws_vpc_attachment" "demo_vpc_attachment" {
  vpc_id       = aws_vpc.demo_vpc.id
  internet_gateway_id = aws_internet_gateway.demo_igw.id
}

// Create Route Tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "private-route-table"
  }
}

// Associate Subnets with Route Tables
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "my_sg" {
   name = "demo-sg"
   ingress {
    vpc_id = aws_vpc.demo_vpc.id
    description = "SSH"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
   }
   Tags = {
    Name = "demo-sg"
   }

}


// Launch Instances in Subnets
resource "aws_instance" "public_instance_1" {
  count = 2
  ami = var.ami  // Replace with your desired AMI ID
  vpc_security_group_id = [aws_security_group.my_sg.id]
  instance_type = var.instance_type  // Replace with your desired instance type
  subnet_id = aws_subnet.public_subnet_1.id
  key_name = "your-keypair-name"  // Replace with your SSH key pair name

  tags = {
    Name = "public-instance-${count.index + 1}"
  }
}

resource "aws_instance" "public_instance_2" {
  count = length(var.public_instances)
  ami = var.ami  // Replace with your desired AMI ID
  vpc_security_group_id = [aws_security_group.my_sg.id]
  instance_type = var.instance_type // Replace with your desired instance type
  subnet_id = aws_subnet.public_subnet_2.id
  key_name = "your-keypair-name"  // Replace with your SSH key pair name

  tags = {
    Name = public_instances[count.index]
  }
}

resource "aws_instance" "private_instance_1" {
  count = length(var.private_instances)
  ami = var.ami  // Replace with your desired AMI ID
  vpc_security_group_id = [aws_security_group.my_sg.id]
  instance_type = var.instance_type  // Replace with your desired instance type
  subnet_id = aws_subnet.private_subnet_1.id
  key_name = "your-keypair-name"  // Replace with your SSH key pair name

  tags = {
    Name = var.private_instances[count.index]
  }
}

resource "aws_instance" "private_instance_2" {
  count = 2
  ami = var.ami  // Replace with your desired AMI ID
  vpc_security_group_id = [aws_security_group.my_sg.id]
  instance_type = var.instance_type  // Replace with your desired instance type
  subnet_id = aws_subnet.private_subnet_2.id
  key_name = "your-keypair-name"  // Replace with your SSH key pair name

  tags = {
    Name = "private-instance-${count.index + 1}"
  }
}
