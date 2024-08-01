variable "region" {
    type = string
    default = "use-east-1"
}

variable "instances" {
    type = list(string)
    default = ["docker-practice", "Ansible", "kubernetes"]
}

variable "instance-type" {
    type = string
    default = "t2.micro"
}

variable "ami" {
    type = string
    default = ""
}