resource "aws_db_subnet_group" "my_rds_subnet" {
    name =  "my_rds_subnet"
    subnet_ids = [
        "subnet-0e40e13af310eb0f0",
        "subnet-0bd2a6db82585a589"
    ]
       
}







