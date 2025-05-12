terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "Terout_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Terout_vpc"
  }
}

resource "aws_subnet" "Terout_pubsub_1" {
  vpc_id = aws_vpc.Terout_vpc.id
  cidr_block = var.pubsub_1_cidr
  availability_zone = var.pubsub_1_az

  tags = {
    Name = "Terout_pubsub_1"
  }
 }
    
resource "aws_subnet" "Terout_pubsub_2" {
vpc_id = aws_vpc.Terout_vpc.id
cidr_block = var.pubsub_2_cidr
availability_zone = var.pubsub_2_az

  tags = {
    Name = "Terout_pubsub_2"
  }
}

resource "aws_internet_gateway" "Terout_IGW" {
  vpc_id = aws_vpc.Terout_vpc.id

  tags = {
    Name = "Terout_IGW"
  }
}

resource "aws_route_table" "Terout_pubrt" {
  vpc_id = aws_vpc.Terout_vpc.id

  route {
    cidr_block = var.default_ip
    gateway_id = aws_internet_gateway.Terout_IGW.id
  }

  tags = {
    Name = "Terout_pubrt"
  }
}

resource "aws_route_table_association" "Terout_pubrt_ass_1" {
  route_table_id = aws_route_table.Terout_pubrt.id
  subnet_id = aws_subnet.Terout_pubsub_1.id
}

resource "aws_route_table_association" "Terout_pubrt_ass_2" {
  route_table_id = aws_route_table.Terout_pubrt.id
  subnet_id = aws_subnet.Terout_pubsub_2.id
}

resource "aws_security_group" "Terout_sg" {
  vpc_id = aws_vpc.Terout_vpc.id

  ingress {
    from_port = 0
    to_port = 0
    cidr_blocks = [var.default_ip]
    protocol = -1
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = [var.default_ip]
    protocol = -1
  }

  tags = {
   Name = "Terout_sg"
  }
}

  resource "aws_key_pair" "Terout_keypair" {
  key_name = "Terout_keypair"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = "Terout_keypair"
  }
}

resource "aws_network_interface" "pub_int_1" {
  subnet_id = aws_subnet.Terout_pubsub_1.id
  security_groups = [aws_security_group.Terout_sg.id]
}

resource "aws_eip" "Terout_eip_1" {
  domain = "vpc"
  network_interface = aws_network_interface.pub_int_1.id

  tags = {
    Name = "Terout_eip_1"
  }
}

resource "aws_network_interface" "pub_int_2" {
  subnet_id = aws_subnet.Terout_pubsub_2.id
  security_groups = [aws_security_group.Terout_sg.id]
}

resource "aws_eip" "Terout_eip_2" {
  domain = "vpc"
  network_interface = aws_network_interface.pub_int_2.id

  tags = {
    Name = "Terout_eip_2"
  }
}

resource "aws_instance" "Terout_Ec2_1" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.Terout_keypair.key_name

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.pub_int_1.id
  }

  user_data = var.user_data_1

  tags = {
    Name = "Terout_Ec2_1"
  }
}

resource "aws_instance" "Terout_Ec2_2" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.Terout_keypair.key_name

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.pub_int_2.id
  }

  user_data = var.user_data_2

  tags = {
    Name = "Terout_Ec2_2"
  }
}

resource "aws_lb" "Terout_alb" {
 name = "Teroutalb"
 load_balancer_type = var.load_balancer_type
 internal = false
 security_groups = [aws_security_group.Terout_sg.id]
 subnet_ids = [aws_subnet.Terout_pubsub_1.id, aws_subnet.Terout_pubsub_2.id]
}

resource "aws_lb_target_group" "Terout_alb_tg" {
 name = "Teroutalbtg"
 vpc_id = aws_vpc.Terout_vpc.id
 port = 80
 protocol = "HTTP"

 health_check {
  path = "/"
  protocol = "Http"
  matcher = "200"
  interval = 30
  timeout = 5
  healthy_threshold = 2
  unhealthy_threshold = 2
 }
}

resource "aws_lb_listener" "Terout_alb_listener" {
 load_balancer_arn = aws_lb.Terout_alb.arn
 port = 80
 protocol = "Http"

 default_action {
  type = "forward"
  target_group_arn = aws_lb_target_group.Terout_alb_tg.arn
 }
}