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
