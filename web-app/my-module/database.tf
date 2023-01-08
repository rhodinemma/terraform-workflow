resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "password" {
  name = "test-db-password"
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.password.id
  secret_string = random_password.master.result
}

resource "aws_db_instance" "db_instance" {
  identifier          = var.db_name
  instance_class      = "db.t3.micro"
  allocated_storage   = 10
  engine              = "postgres"
  engine_version      = "13.7"
  username            = var.db_user
  password            = var.db_pass
  publicly_accessible = true
  skip_final_snapshot = true
}
