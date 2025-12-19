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