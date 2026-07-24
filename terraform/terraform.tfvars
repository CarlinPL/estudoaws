aws_region   = "sa-east-1"
project_name = "estudo-terraform"

vpc_cidr = "10.0.0.0/16"

availability_zones    = ["sa-east-1a", "sa-east-1b"]
private_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidrs   = ["10.0.100.0/24", "10.0.200.0/24"]
instance_type = "t3.micro"
key_name ="pcgoku2"
