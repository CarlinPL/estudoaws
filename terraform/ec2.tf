# Busca automaticamente a AMI Ubuntu mais recente
# para a região configurada, evitando fixar um AMI ID manualmente.
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Uma instancia EC2 por subnet privada (1 por AZ)
resource "aws_instance" "testevpc" {
  count = length(aws_subnet.private)

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private[count.index].id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "${var.project_name}-ec2-${count.index + 1}-${var.availability_zones[count.index]}"
  }
}
