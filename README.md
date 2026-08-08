# Simulador de Financiamento Veicular - Infraestrutura

Infraestrutura AWS via Terraform: DynamoDB, Secrets Manager, IAM.
Ambiente local via ministack.org (DynamoDB Local + Secrets Manager Local).

## Pré-requisitos

- Terraform >= 1.5
- AWS CLI (para init local)
- Docker (para ministack.org)

## Setup Local

```bash
docker compose up -d
./scripts/init-local.sh
```

## Provisionamento AWS

```bash
cd terraform
terraform init
terraform plan
terraform apply
```
