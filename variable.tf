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

 variable "default_ip" {
  description = "default ip address"
  type = string
  default = "0.0.0.0/0"
 }

varibale "instance_type" {
 description = "instance type for aws ec2 instance"
 type = string
 default = "t2.micro"
}

variable "ami_id" {
 description = "ami id for aws ec2 instance"
 type = string
 default = "ami-084568db4383264d4"
}

variable "public_key_location" {
 description = "location of public key"
 type = string
 default = "file(~/.ssh/id_rsa.pub)"
}

variable "user_data" {
 description = "user data for aws ec2"
 type = string
 default = <<-EOF
           #!/bin/bash
           apt update -y
           apt install -y apache2
           systemctl start apache2
           systemctl enable apache2
           echo "Hello from EC2 via Terraform!" > /var/www/html/index.html
           EOF
}