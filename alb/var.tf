variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "name" {
  description = "Name prefix for ALB"
  type        = string
  default     = "jaya"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0b07a3c9b6f48f9ed"
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)

  default = [
    "subnet-0dbffbdf2e0355e54",
    "subnet-03c813f8f90702604"
  ]
}
