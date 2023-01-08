terraform {
  backend "remote" {
    organization = "rhodin"

    workspaces {
      name = "rhodin-workspace"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_secretsmanager_secret" "password" {
  name = "test-db-password"

}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = data.aws_secretsmanager_secret.password
}

module "web_app_1" {
  source = "./my-module"

  # Input Variables
  bucket_name      = "web-app-1-rhodin-web-app-data"
  domain           = "devopsdeployed.com"
  app_name         = "web-app-1"
  environment_name = "production"
  instance_type    = "t2.small"
  create_dns_zone  = true
  db_name          = "webapp1db"
  db_user          = "foo"
  db_pass          = data.aws_secretsmanager_secret_version.password
}

module "web_app_2" {
  source = "./my-module"

  # Input Variables
  bucket_name      = "web-app-2-rhodin-web-app-data"
  domain           = "anotherdevopsdeployed.com"
  app_name         = "web-app-2"
  environment_name = "production"
  instance_type    = "t2.small"
  create_dns_zone  = true
  db_name          = "webapp2db"
  db_user          = "bar"
  db_pass          = data.aws_secretsmanager_secret_version.password
}
