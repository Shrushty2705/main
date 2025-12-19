## rds 
output "db_port" {
    value = aws_db_instance.my_rds.port
}
output "db_storage" {
    value = aws_db_instance.my_rds.allocated_storage 
}
output "db_name" {
    value = aws_db_instance.my_rds.db_name 
}

## subnet
output "subnet_region" {
    value = aws_db_subnet_group.my_rds_subnet.region
  
}