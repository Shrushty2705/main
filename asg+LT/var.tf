variable "image_id" {
    default = "ami-0fa91bc90632c73c9"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "key_name" {
    default = "Ubkey"
}

variable "vpc_security_group_ids" {
    default = "sg-09040ae4cd8504987"
}