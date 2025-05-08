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

resource "aws_subnet" "Terout_pubsub" {
  vpc_id = aws_vpc.Terout_vpc.id
  cidr_block = var.pubsub_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "Terout_pubsub"resource "aws_subnet" "Terout_prisub" {
  vpc_id = aws_vpc.Terout_vpc.id
  cidr_block = var.prisub_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "Terout_prisub"
  }
}

resource "aws_internet_gateway" "Terout_IGW" {
  vpc_id = aws_vpc.Terout_vpc.id

  tags = {
    Name = "Terout_IGW"
  }
}resource "aws_route_table" "Terout_pubrt" {
  vpc_id = aws_vpc.Terout_vpc.id

  route {
    cidr_block = var.default_ip
    gateway_id = aws_internet_gateway.Terout_IGW.id
  }

  tags = {
    Name = "Terout_pubrt"
  }
}

resource "aws_route_table" "Terout_prirt"{
  vpc_id = aws_vpc.Terout_vpc.id

  tags = {
    Name = "Terout_prirt"
  }
}

resource "aws_route_table_association" "Terout_pubrt_ass" {
  route_table_id = aws_route_table.Terout_pubrt.id
  subnet_id = aws_subnet.Terout_pubsub.idresource "aws_route_table_association" "Terout_prirt_ass" {
  route_table_id = aws_route_table.Terout_prirt.id
  subnet_id = aws_subnet.Terout_prisub.id
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

  tags = {resource "aws_key_pair" "Terout_keypair" {
  key_name = "Terout_keypair"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = "Terout_keypair"
  }
}

resource "aws_network_interface" "pub_int" {
  subnet_id = aws_subnet.Terout_pubsub.id
  security_groups = [aws_security_group.Terout_sg.id]
}

resource "aws_eip" "Terout_eip" {
  domain = "vpc"
  network_interface = aws_network_interface.pub_int.id

  tags = {
    Name = "Terout_eip"
  }
}

resource "aws_network_interface" "pri_int" {
  subnet_id = aws_subnet.Terout_prisub.id
}

resource "aws_instance" "Terout_Ec2" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.Terout_keypair.key_name

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.pub_int.id
  }

  network_interface {
    device_index = 1
    network_interface_id = aws_network_interface.pri_int.id
  }

  user_data = var.user_data

  tags = {
    Name = "Terout_Ec2"
  }
}
    Name = "Terout_sg"
  }
}


}




  }
}

