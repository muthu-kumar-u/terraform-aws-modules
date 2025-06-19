# versions.tf

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      version = "~> 3.6.2"
    }
  }

  required_version = "~> 1.12.2"
}