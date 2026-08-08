# simulador-infra

Infraestrutura AWS provisionada via Terraform para o **Simulador de Financiamento Veicular**. Ambiente local via DynamoDB Local com script de inicialização automatizada.

## Estrutura

```
.
├── terraform/
│   ├── main.tf           # Provider AWS + DynamoDB + Secrets Manager
│   ├── variables.tf       # Variáveis de entrada (região, ambiente)
│   ├── outputs.tf         # Outputs (ARNs das tabelas e secret)
│   ├── iam.tf             # IAM user + políticas de acesso
│   └── versions.tf        # Provider version constraints
├── docker/
│   ├── docker-compose.yml # DynamoDB Local (porta 8000)
│   └── init/
│       └── create-tables.sh  # Cria tabelas e GSIs via AWS CLI
├── scripts/
│   └── init-local.sh      # Orquestra Docker + criação de tabelas
└── README.md
```

## Pré-requisitos

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5.0
- [AWS CLI](https://aws.amazon.com/cli/)
- [Docker](https://www.docker.com/products/docker-desktop/)
- Credenciais AWS configuradas (`aws configure`)

## Ambiente Local

Para subir o ambiente local completo (DynamoDB Local + tabelas + GSIs):

```bash
./scripts/init-local.sh
```

Isso irá:

1. Subir o container DynamoDB Local na porta 8000
2. Aguardar a porta responder
3. Criar as 3 tabelas (`simulacoes`, `taxas`, `parametros`) com seus GSIs

### Parar o ambiente

```bash
docker compose -f docker/docker-compose.yml down
```

## Terraform

### Inicializar

```bash
cd terraform
terraform init
```

### Validar

```bash
terraform validate
```

### Planejar

```bash
terraform plan
```

### Aplicar

```bash
terraform apply
```

## Recursos Provisionados

| Recurso | Tipo | Nome |
|---|---|---|
| DynamoDB Table | `aws_dynamodb_table` | `simulacoes` (PK: `id`, SK: `userId`, GSI: `userId-index`) |
| DynamoDB Table | `aws_dynamodb_table` | `taxas` (PK: `id`, GSI: `ativa-index`) |
| DynamoDB Table | `aws_dynamodb_table` | `parametros` (PK: `chave`) |
| Secrets Manager | `aws_secretsmanager_secret` | `simulador/dynamodb/credentials` |
| IAM User | `aws_iam_user` | `simulador-app-user` |
| IAM Policy | `aws_iam_policy` | `simulador-dynamodb-access` (GetItem, PutItem, UpdateItem, Query, Scan) |
| IAM Policy | `aws_iam_policy` | `simulador-secretsmanager-access` (GetSecretValue) |

Todas as tabelas DynamoDB usam `billing_mode = "PAY_PER_REQUEST"` (on-demand).
