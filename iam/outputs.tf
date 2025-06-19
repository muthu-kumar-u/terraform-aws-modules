# infra/shared/iam/outputs.tf

output "iam_roles" {
  description = "IAM roles created"
  value = {
    for k, v in aws_iam_role.roles :
    k => {
      name = v.name
      arn  = v.arn
    }
  }
}

output "iam_instance_profiles" {
  description = "Instance profiles for IAM roles"
  value = {
    for k, v in aws_iam_instance_profile.profiles :
    k => {
      name = v.name
      arn  = v.arn
    }
  }
}

output "iam_users" {
  description = "IAM users created"
  value = {
    for k, v in aws_iam_user.users :
    k => {
      name = v.name
      arn  = v.arn
    }
  }
}

output "iam_policies" {
  description = "Custom IAM policies created"
  value = {
    for k, v in aws_iam_policy.custom :
    k => {
      name = v.name
      arn  = v.arn
    }
  }
}

output "oidc_providers" {
  description = "IAM OpenID Connect providers"
  value = {
    for k, v in aws_iam_openid_connect_provider.oidc :
    k => {
      url = v.url
      arn = v.arn
    }
  }
}