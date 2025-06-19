# infra/shared/iam/variables.tf

variable "iam_roles" {
  description = "Map of IAM roles to create"
  type = map(object({
    name                   = string
    assume_role_policy     = string
    managed_policies       = optional(list(string), [])
    inline_policies        = optional(map(string), {})
    create_instance_profile = optional(bool, false)
  }))
}

variable "iam_users" {
  description = "Map of IAM users to create"
  type = map(object({
    name            = string
    inline_policies = optional(map(string), {})
  }))
}

variable "iam_policies" {
  description = "Map of custom IAM policies to create"
  type = map(object({
    name        = string
    path        = optional(string, "/")
    description = optional(string, "")
    policy      = string
  }))
}

variable "policy_attachments" {
  description = "List of managed policy attachments for user, role, or group"
  type = list(object({
    target_type = string  # "user", "role", or "group"
    target_name = string
    policy_arn  = string
  }))

  validation {
    condition     = alltrue([for a in var.policy_attachments : contains(["user", "role", "group"], a.target_type)])
    error_message = "Each policy attachment must have a target_type of 'user', 'role', or 'group'."
  }
}

variable "oidc_providers" {
  description = "Map of OIDC provider configurations"
  type = map(object({
    url             = string
    client_id_list  = list(string)
    thumbprint_list = list(string)
  }))
}