provider "aws" {
    region = "ap-south-1"
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
        Name ="my_instance_sk"
        env = var.env
    }
}

resource "aws_security_group" "aws_sg" {
    name = "sg_name_sk"
    description = "Allow All Traffic"
    vpc_id = "vpc-0b07a3c9b6f48f9ed"   
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }//

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
