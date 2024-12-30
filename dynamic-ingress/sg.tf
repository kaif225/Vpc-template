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

// if we want to use different ports for different cidr then we have to do the below, it will create a map that set cidr_block for each ports so that we have different cidr ofr different ports in a security group


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
////////////////////////////////////////////////////////////////////////////////////

locals {
    map = {
      "http rule" = {
        port = 80
        cidr_block = ["0.0.0.0/0"]
      }
      "ssh port" = {
        port = 22
        cidr_block = ["192.168.21.0/20"]
      }
    }
}

resource "aws_security_group" "my_group" {
   dynamic "ingress" {
     for_each = locals.map
     content {
        description = ingress.key
        from_port = ingress.value.port
        to_port = ingress.value.port
        cidr_blocks = ingress.value.cidr_block
     }
   }
}

output "map" {
  value = aws_security_group.foreachusecase
}


/*

locals {
   ingress_rule = [{
     port = 443
     },
    { 
    port = 80
     }
   ]
  }

  resource "aws_security_group" "web_sg" {
    name = ""
    vpc_id =
    dynamic "ingress" {
      for_each = local.ingress_rule
      port = ingress.value
    }
  }



*/