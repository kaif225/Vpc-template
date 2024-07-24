variable "region" {
    type = string
    default = "us-east-1"
}


variable "instance-type" {
    type = string
    default = "t2.micro"
}

variable "ami" {
    type = string
    default = "ami-04a81a99f5ec58529"
}


variable "vpc_cidr_block" {
    type = string
    default = "10.19.0.0/16"
}

variable "public1_cb" {
  type = string
  default = "10.19.1.0/24"
}

variable "public2_cb" {
  type = string
  default = "10.19.2.0/24"
}

variable "private1_cb" {
  type = string
  default = "10.19.20.0/24"
}
variable "private2_cb" {
  type = string
  default = "10.19.21.0/24"
}

variable "instance" {
  type = list(string)
  default = ["public-instance1", "public-instance2"]
}

