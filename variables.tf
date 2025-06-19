# infra/environments/prod/variables.tf

# General Configuration
variable "region" {
  description = "Aws region"
  type        = string
}

variable "role_arn" {
  description = "Runner arn"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. prod, dev)"
  type        = string
}

variable "operator" {
  description = "Owner of this run"
  type        = string
}

