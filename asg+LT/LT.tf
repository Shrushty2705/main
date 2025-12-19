provider "aws" {
    region = "eu-north-1" 
}

resource "aws_launch_template" "my_template1" {
    name_prefix = "my_template1"
    image_id    =  var.image_id
    instance_type  = var.instance_type
    key_name  =  var.key_name
    vpc_security_group_ids = var.vpc_security_group_ids

user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    echo "<h1> Hello World </h1>" > /var/www/html/index.html
    EOF

    tags =  {
        Name = "my_LT_Instance"
      
    }


}