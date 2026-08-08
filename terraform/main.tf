provider "aws" {
  region = var.aws_region
}

resource "aws_dynamodb_table" "simulacoes" {
  name         = "simulacoes"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  range_key    = "userId"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "dataSimulacao"
    type = "S"
  }

  global_secondary_index {
    name            = "userId-index"
    hash_key        = "userId"
    range_key       = "dataSimulacao"
    projection_type = "ALL"
  }
}

resource "aws_dynamodb_table" "taxas" {
  name         = "taxas"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "ativa"
    type = "S"
  }

  attribute {
    name = "prazoMinimoMeses"
    type = "N"
  }

  global_secondary_index {
    name            = "ativa-index"
    hash_key        = "ativa"
    range_key       = "prazoMinimoMeses"
    projection_type = "ALL"
  }
}

resource "aws_dynamodb_table" "parametros" {
  name         = "parametros"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "chave"

  attribute {
    name = "chave"
    type = "S"
  }
}

resource "aws_secretsmanager_secret" "dynamodb_credentials" {
  name = "simulador/dynamodb/credentials"
}
