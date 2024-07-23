variable "region" {
    type = string 
    default = "us-east-1"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "ami" {
    type = string
    default = "ami-"
}
variable "public_instances" {
    type = list(string)
    default = ["public-instance1", "public-instance2"]
}

variable "private_instances" {
    type = list(string)
    default = ["private-instance1", "private-instance2"]
}


variable "vpc_cidr" {
    type = string
    default = "10.19.0.0/16"
}

variable "public_subnet1" {
    type = string
    default = "10.19.1.0/24"
}

variable "public_subnet2" {
    type = string
    default = "10.19.2.0/24"
}

variable "private_subnet1" {
    type = string
    default = "10.19.20.0/24"
}

variable "private_subnet2" {
    type = string
    default = "10.19.21.0/24"
}