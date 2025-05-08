output "vpc_id" {
  description = "Vpc_id"
  value = aws_vpc.Terout_vpc.id
}

output "private_interface_ip" {
  description = "private interface ip"
  value = aws_network_interface.pri_int.private_ips
}

output "private_interface_id" {
  description = "private interface id"
  value = aws_network_interface.pri_int.id
}

output "public_interface_ip" {
  description = "public interface ip"
  value = aws_network_interface.pub_int.private_ips
}

output "public_interface_id" {
  description = "public interface id"
  value = aws_network_interface.pub_int.private_ips
}

output "Eip" {
  description = "public ip from eip"
  value = aws_eip.Terout_eip.public_ip
}

output "ec2_instance_id" {
  description = "Ec2 instance id"
  value = aws_instance.Terout_Ec2.id
}