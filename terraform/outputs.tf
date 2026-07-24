output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"
  value       = aws_subnet.private[*].id
}

output "ec2_instance_ids" {
  description = "IDs das instancias EC2 criadas"
  value       = aws_instance.testevpc[*].id
}

output "ec2_private_ips" {
  description = "IPs privados das instancias EC2"
  value       = aws_instance.testevpc[*].private_ip
}
