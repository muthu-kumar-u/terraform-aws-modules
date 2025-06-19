# infra/environments/prod/providers.tf

provider "aws" {
  region = var.region

  assume_role {
    role_arn     = var.role_arn
    session_name = "terraform-session-${terraform.workspace}"

    tags = {
      Terraform        = "true"
      Workspace        = terraform.workspace
      TerraformProject = var.project_name
    }
  }

  default_tags {
    tags = {
      Environment     = terraform.workspace
      TerraformModule = basename(abspath(path.module))
      ManagedBy       = "Terraform"
      Project         = var.project_name
    }
  }
}