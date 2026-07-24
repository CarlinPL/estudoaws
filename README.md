# Projeto Terraform - VPC com 2 AZs, subnets privadas e EC2

Este projeto cria na AWS:

- 1 VPC
- 2 subnets **privadas**, uma em cada uma das 2 zonas de disponibilidade (AZs)
- 1 instância EC2 dentro de cada subnet privada
- Route tables privadas (sem rota para a internet)
- 1 Security Group compartilhado pelas instâncias

## Estrutura dos arquivos

```
.
├── versions.tf              # Versão do Terraform e do provider AWS
├── providers.tf              # Configuração do provider AWS
├── variables.tf               # Variáveis de entrada (região, CIDRs, AZs, etc)
├── vpc.tf                       # Recurso da VPC
├── subnets.tf                 # As 2 subnets privadas (uma por AZ)
├── route_tables.tf         # Route tables privadas + associações
├── security_groups.tf   # Security Group das instâncias
├── ec2.tf                        # Instâncias EC2 (uma por subnet)
├── outputs.tf                 # Saídas úteis (IDs, IPs)
└── terraform.tfvars.example   # Exemplo de valores customizáveis
```

## Como usar

1. Copie o arquivo de exemplo de variáveis:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
   E ajuste `aws_region`, `availability_zones` etc. conforme sua conta/região.

2. Configure suas credenciais AWS (uma das opções):
   ```bash
   aws configure
   # ou
   export AWS_ACCESS_KEY_ID="..."
   export AWS_SECRET_ACCESS_KEY="..."
   ```

3. Inicialize o Terraform:
   ```bash
   terraform init
   ```

4. Veja o plano de execução:
   ```bash
   terraform plan
   ```

5. Aplique:
   ```bash
   terraform apply
   ```

6. Para destruir tudo depois:
   ```bash
   terraform destroy
   ```

## Importante: instâncias sem acesso à internet

Como as subnets são **privadas** e este projeto não cria Internet Gateway nem NAT Gateway,
as instâncias EC2 **não terão acesso de saída à internet** (não conseguem baixar pacotes, por exemplo)
e também não são acessíveis via SSH direto da sua máquina.

Isso é esperado para uma arquitetura privada "pura". Para acessar ou dar internet às instâncias,
as opções mais comuns são:

- **NAT Gateway**: permite que as instâncias privadas acessem a internet para saída (ex: `yum update`),
  mas ninguém de fora consegue iniciar conexão com elas. Requer subnet(s) pública(s) + Internet Gateway.
- **VPC Endpoints + AWS Systems Manager (SSM)**: permite acessar o terminal da instância
  via Session Manager, sem precisar de SSH nem IP público.
- **Bastion Host**: uma instância em subnet pública que serve de "ponte" para acessar via SSH
  as instâncias privadas.

Se quiser, posso estender este projeto adicionando qualquer uma dessas opções.

## Próximos passos sugeridos para estudo

- Adicionar um NAT Gateway + subnets públicas
- Adicionar Auto Scaling Group ao invés de instâncias fixas
- Usar módulos Terraform (`module`) para reaproveitar este código
- Adicionar um backend remoto (S3 + DynamoDB) para o state
