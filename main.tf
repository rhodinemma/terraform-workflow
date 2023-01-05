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
