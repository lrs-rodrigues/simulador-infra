#!/usr/bin/env bash
set -euo pipefail

ENDPOINT="http://localhost:8000"

echo "Criando tabela: simulacoes"
aws dynamodb create-table \
  --table-name simulacoes \
  --attribute-definitions \
    AttributeName=id,AttributeType=S \
    AttributeName=userId,AttributeType=S \
    AttributeName=dataSimulacao,AttributeType=S \
  --key-schema \
    AttributeName=id,KeyType=HASH \
    AttributeName=userId,KeyType=RANGE \
  --global-secondary-indexes '[
    {
      "IndexName": "userId-index",
      "KeySchema": [
        {"AttributeName": "userId", "KeyType": "HASH"},
        {"AttributeName": "dataSimulacao", "KeyType": "RANGE"}
      ],
      "Projection": {"ProjectionType": "ALL"}
    }
  ]' \
  --billing-mode PAY_PER_REQUEST \
  --endpoint-url "$ENDPOINT" \
  --no-cli-pager

echo "Criando tabela: taxas"
aws dynamodb create-table \
  --table-name taxas \
  --attribute-definitions \
    AttributeName=id,AttributeType=S \
    AttributeName=ativa,AttributeType=S \
    AttributeName=prazoMinimoMeses,AttributeType=N \
  --key-schema \
    AttributeName=id,KeyType=HASH \
  --global-secondary-indexes '[
    {
      "IndexName": "ativa-index",
      "KeySchema": [
        {"AttributeName": "ativa", "KeyType": "HASH"},
        {"AttributeName": "prazoMinimoMeses", "KeyType": "RANGE"}
      ],
      "Projection": {"ProjectionType": "ALL"}
    }
  ]' \
  --billing-mode PAY_PER_REQUEST \
  --endpoint-url "$ENDPOINT" \
  --no-cli-pager

echo "Criando tabela: parametros"
aws dynamodb create-table \
  --table-name parametros \
  --attribute-definitions \
    AttributeName=chave,AttributeType=S \
  --key-schema \
    AttributeName=chave,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --endpoint-url "$ENDPOINT" \
  --no-cli-pager

echo "Todas as tabelas criadas com sucesso."
