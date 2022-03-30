
resource "random_password" "api_secret_app" {
  length           = 64
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "vault_api_secret" {

  name   = "${var.name}-api-key-app"
  
}

resource "aws_secretsmanager_secret_version" "vault_api_secret" {
  secret_id     = aws_secretsmanager_secret.vault_api_secret.id
  secret_string = "${random_password.api_secret_app.result}"
}
