variable "aws_region" {
 description = "AWS region for aws resource"
 type = string
 default = "us-east-1"
}

variable "availability_zone" {
 description = "AZ for aws resource"
 type = string
 default = "us-east-1a"
}

variable "vpc_cidr" {
 description = "cidr for vpc"
 type = string
 default = "172.168.0.0/16"
 }

 variable "pubsub_cidr" {
  description = "cidr for public subnet"
  type = string
  default = "172.168.0.0/24"
 }

 variable "prisub_cidr" {
  description = "cidr for private subnet"
  type = string
  default = "172.168.1.0/24"
 }