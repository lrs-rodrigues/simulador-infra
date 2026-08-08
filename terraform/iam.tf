resource "aws_iam_user" "simulador_app" {
  name = "simulador-app-user"
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "simulador-dynamodb-access"
  description = "Access to simulador DynamoDB tables"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          aws_dynamodb_table.simulacoes.arn,
          aws_dynamodb_table.taxas.arn,
          aws_dynamodb_table.parametros.arn,
          "${aws_dynamodb_table.simulacoes.arn}/index/*",
          "${aws_dynamodb_table.taxas.arn}/index/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "secretsmanager_access" {
  name        = "simulador-secretsmanager-access"
  description = "Access to simulador Secrets Manager secret"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["secretsmanager:GetSecretValue"]
        Resource = [aws_secretsmanager_secret.dynamodb_credentials.arn]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "simulador_dynamodb" {
  user       = aws_iam_user.simulador_app.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_iam_user_policy_attachment" "simulador_secretsmanager" {
  user       = aws_iam_user.simulador_app.name
  policy_arn = aws_iam_policy.secretsmanager_access.arn
}
