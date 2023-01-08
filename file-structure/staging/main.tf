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

locals {
  environment_name = "staging"
}

module "web_app" {
  source = "../../web-app/my-module"

  # Input Variables
  bucket_name      = "rhodin-web-app-data-${local.environment_name}"
  domain           = "devopsdeployed.com"
  environment_name = local.environment_name
  instance_type    = "t2.micro"
  create_dns_zone  = true
}
