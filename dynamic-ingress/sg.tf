resource "aws_security_group" "dynamic-sg" {
    dynamic "ingress" {
        for_each = var.ports
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

// if we want to use different blocks for different cidr then we have to do the below, it will create a map that set cidr_block for each ports so that we have different cidr ofr different ports in a security group


variable "cidr_blocks" {
  type    = list(string)
  default = ["192.168.7.239/32", "0.0.0.0/0", "10.0.0.0/24", "172.16.0.0/16"]
}



locals {
  ingress_rules = [for idx, port in var.ports : {
    from_port   = port
    to_port     = port
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks[idx]]
  }]
}


resource "aws_security_group" "dynamic-sg" {
  // Define other necessary parameters for the security group here

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
