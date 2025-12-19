provider "aws" {
    region = "eu-north-1"
}

module "db" {
   source = "./rds"

   #rds
   engine_version = var.engine_version
   instance_class =  "db.t3.micro"
   username = var.username
   password = var.password


} 