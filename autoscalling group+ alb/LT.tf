provider "aws" {
  region = "eu-north-1"
}

resource "aws_launch_template" "my_template" {
  name_prefix = "my-template"
  image_id    = "ami-0fa91bc90632c73c9"    #  AMI
  instance_type = "t3.micro"
  key_name      = "Ubkey"                  # key pair in eu-north-1
  vpc_security_group_ids = ["sg-09040ae4cd8504987"]

  user_data = base64encode(<<EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
echo "<h1>Hello World from ASG + ALB</h1>" > /var/www/html/index.html
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "example-asg-instance"
    }
  }
}