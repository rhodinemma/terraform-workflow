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

# Route53 zone is shared across staging and production
resource "aws_route53_zone" "primary" {
  name = "devopsdeployed.com"
  lifecycle {
    ignore_changes = [
      name
    ]
  }
}
