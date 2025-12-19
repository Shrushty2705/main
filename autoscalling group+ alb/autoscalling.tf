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

  target_group_arns = [aws_lb_target_group.my_tg.arn]

  tag {
    key                 = "Name"
    value               = "example-asg"
    propagate_at_launch = true
  }
}