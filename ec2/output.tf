output "public_ip" {
    value = aws_instance.my-instance.public_ip
}

output "private_ip" {
    value = aws_instance.my-instance.private_ip
}

output "public_dns" {
    value = aws_instance.my-instance.public_dns
}
output "subnet_ip" {
    value = aws_instance.my-instance.subnet_id
}