output "dynamodb_table_simulacoes_arn" {
  description = "ARN da tabela simulacoes"
  value       = aws_dynamodb_table.simulacoes.arn
}

output "dynamodb_table_taxas_arn" {
  description = "ARN da tabela taxas"
  value       = aws_dynamodb_table.taxas.arn
}

output "dynamodb_table_parametros_arn" {
  description = "ARN da tabela parametros"
  value       = aws_dynamodb_table.parametros.arn
}

output "secrets_manager_secret_arn" {
  description = "ARN do secret simulador/dynamodb/credentials"
  value       = aws_secretsmanager_secret.dynamodb_credentials.arn
}
