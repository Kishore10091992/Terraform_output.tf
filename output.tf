output "vpc_id" {
  description = "Vpc_id"
  value = aws_vpc.Terout_vpc.id
}

output "public_interface_1_ip" {
  description = "private interface ip"
  value = aws_network_interface.pub_int_1.private_ips
}

output "public_interface_1_id" {
  description = "private interface id"
  value = aws_network_interface.pub_int_1.id
}

output "public_interface_2_ip" {
  description = "public interface ip"
  value = aws_network_interface.pub_int_2.private_ips
}

output "public_interface_2_id" {
  description = "public interface id"
  value = aws_network_interface.pub_int_2.id
}

output "Eip_1" {
  description = "public ip from eip"
  value = aws_eip.Terout_eip_1.public_ip
}

output "Eip_2" {
  description = "public ip from eip"
  value = aws_eip.Terout_eip_2.public_ip
}

output "ec2_instance_id_1" {
  description = "Ec2 instance id"
  value = aws_instance.Terout_Ec2_1.id
}

output "ec2_instance_id_2" {
  description = "Ec2 instance id"
  value = aws_instance.Terout_Ec2_2.id
}

output "alb_id" {
 description = "alb id"
 value = aws_lb.Terout_alb.id
}

output "alb_dns_name" {
 description = "alb dns name"
 value = aws_lb.Terout_alb.dns_name
}

output "alb_arn" {
 description = "alb_arn"
 value = aws_lb.Terout_alb.arn
}

output "alb_tg_arn" {
 description = "alb tg arn"
 value = aws_lb_target_group.Terout_alb_tg.arn
}

output "alb_listener_arn" {
 description = "alb listener arn"
 value = aws_lb_listener.Terout_alb_listner.arn
}