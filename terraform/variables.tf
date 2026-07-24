variable "aws_region" {
  description = "Região da AWS onde os recursos serão criados"
  type        = string
  default     = "sa-east-1"
}

variable "project_name" {
  description = "Nome do projeto, usado como prefixo nas tags"
  type        = string
  default     = "estudo-terraform"
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Duas AZs, uma para cada subnet privada
variable "availability_zones" {
  description = "Lista com as 2 zonas de disponibilidade usadas"
  type        = list(string)
  default     = ["sa-east-1a", "sa-east-1b"]
}

# Um CIDR de subnet para cada AZ (mesma ordem da lista acima)
variable "private_subnet_cidrs" {
  description = "CIDRs das subnets privadas 1 por AZ"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidrs" {
  description = "CIDRs das subnets publicas"
  type        = list(string)
  default     = ["10.0.100.0/24", "10.0.200.0/24"]
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nome chave SSH"
  type        = string
  default     = null
}


