#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> Subindo containers Docker..."
docker compose -f "$PROJECT_DIR/docker/docker-compose.yml" up -d

echo "==> Aguardando DynamoDB Local na porta 8000..."
until curl -s http://localhost:8000 > /dev/null 2>&1; do
  sleep 1
done
echo "==> DynamoDB Local respondeu."

echo "==> Criando tabelas e GSIs..."
bash "$PROJECT_DIR/docker/init/create-tables.sh"

echo ""
echo "==================================="
echo " Ambiente local iniciado com sucesso"
echo "==================================="
echo ""
echo " DynamoDB Local: http://localhost:8000"
echo ""
