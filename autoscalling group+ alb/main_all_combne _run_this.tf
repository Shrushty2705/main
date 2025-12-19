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

## TG

resource "aws_lb_target_group" "my_tg" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-08d274b7fc12560a9"   # <---- Replace with VPC ID

  health_check {
    path = "/"
    protocol = "HTTP"
  }
}


## ALB

resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-09040ae4cd8504987"]
  subnets            = [
    "subnet-0e40e13af310eb0f0",
    "subnet-0bd2a6db82585a589"
  ]
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn          #-----------> In Auto Scalling We refere this to connect (1)
  }
}

 ## Auto Scalling
 
resource "aws_autoscaling_group" "my_asg" {
  name = "my-autoscaling-group"

  launch_template {
    id      = aws_launch_template.my_template.id
    version = "$Latest"
  }

  min_size         = 2
  max_size         = 3
  desired_capacity = 2

  vpc_zone_identifier = [
    "subnet-0e40e13af310eb0f0",
    "subnet-0bd2a6db82585a589"
  ]

  target_group_arns = [aws_lb_target_group.my_tg.arn]        #---------> Refere (1)   ....line no.64

  tag {
    key                 = "Name"
    value               = "example-asg"
    propagate_at_launch = true
  }
}