#Cria VPC na AWS
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

#Cria Internet Gatway 
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
   Name = "${var.project_name}-internet-gateway" 
  }
}

# Cria um IP elastico para cada zona de disponibilidade
resource "aws_eip" "nat" {
  count = length(var.availability_zones)
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-eip-nat-${count.index + 1}"
  }

  depends_on = [ aws_vpc.main ]
}

#Cria um NAT-Gateway e aloca um IP elastico para cada NAT e vincula a uma subnet publica
resource "aws_nat_gateway" "main" {
  count = length(var.availability_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.project_name}-nat-${count.index + 1}"
  }

  depends_on = [ aws_internet_gateway.main ]
}
