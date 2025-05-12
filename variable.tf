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

variable "default_ip" {
 description = "default ip"
 type = string
 default = "0.0.0.0/0"
}

variable "vpc_cidr" {
 description = "cidr for vpc"
 type = string
 default = "172.168.0.0/16"
 }

 variable "pubsub_1_cidr" {
  description = "cidr for public subnet"
  type = string
  default = "172.168.0.0/24"
 }

 variable "pubsub_1_az" {
  description = "az for public subnet 1"
  type = string
  default = "us-east-1a"
 }

 variable "pubsub_2_cidr" {
  description = "cidr for private subnet"
  type = string
  default = "172.168.1.0/24"
 }

 variable "pubsub_2_az" {
  description = "az for public subnet 2"
  type = string
  default = "us-east-1c"
 }

 variable "instance_type" {
  description = "instance_type"
  type = string
  default = "t2.micro"
 }

variable "load_balancer_type" {
 description = "load balancer type"
 type = string
 default = "application"
 }

variable "user_data_1" {
 description = "user data for aws ec2"
 type = string
 default = <<-EOF
           #!/bin/bash
           apt update -y
           apt install -y apache2
           systemctl start apache2
           systemctl enable apache2
           echo "Hello from ALB_1 via Terraform!" > /var/www/html/index.html
           EOF
}

variable "user_data_2" {
 description = "user data for aws ec2"
 type = string
 default = <<-EOF
           #!/bin/bash
           apt update -y
           apt install -y apache2
           systemctl start apache2
           systemctl enable apache2
           echo "Hello from ALB_2 via Terraform!" > /var/www/html/index.html
           EOF
}

variable "ami_id" {
 description = "ami id instance for both ec2"
 type = string
 default = "ami-0f88e80871fd81e91"
}