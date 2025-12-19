provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "my-instance" {
    ami           = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.aws_sg.id]

    user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    echo "<h1> Hello World </h1>" > /var/www/html/index.html
    EOF

    tags = {
        env = var.env
    }
}

resource "aws_security_group" "aws_sg" {
    name = "sg_name"
    description = "Allow All Traffic"
    vpc_id = "vpc-08d274b7fc12560a9"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        env = var.env
    }
}