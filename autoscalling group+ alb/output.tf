output "ALB_DNS" {
  value = aws_lb.my_alb.dns_name
}

output "ALB_Version" {
    value = aws_autoscaling_group.my_asg.version
  
}