# Security Group básico:
# - Permite tráfego SSH (22) apenas de dentro da própria VPC
# - Permite todo tráfego de saída
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-ec2-sg"
  description = "Security group para as instancias EC2 nas subnets privadas"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH somente de dentro da VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Todo trafego de saida liberado"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}
