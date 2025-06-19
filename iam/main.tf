# infra/shared/iam/main.tf

locals {
  iam_managed_policy_attachments = flatten([
    for role_key, role in var.iam_roles : [
      for policy_arn in lookup(role, "managed_policies", []) : {
        key        = "${role_key}-${basename(policy_arn)}"
        role_name  = aws_iam_role.roles[role_key].name
        policy_arn = policy_arn
      }
    ]
  ])

  iam_inline_policies = flatten([
    for role_key, role in var.iam_roles : [
      for policy_name, policy_doc in lookup(role, "inline_policies", {}) : {
        key         = "${role_key}-${policy_name}"
        role_name   = aws_iam_role.roles[role_key].name
        policy_name = policy_name
        policy      = policy_doc
      }
    ]
  ])

  user_inline_policies = flatten([
    for user_key, user in var.iam_users : [
      for policy_name, policy_doc in lookup(user, "inline_policies", {}) : {
        key         = "${user_key}-${policy_name}"
        user_name   = aws_iam_user.users[user_key].name
        policy_name = policy_name
        policy      = policy_doc
      }
    ]
  ])

  iam_policy_attachments = {
    for i, attachment in var.policy_attachments :
    "${attachment.target_type}-${attachment.target_name}-${i}" => attachment
  }
}

resource "aws_iam_role" "roles" {
  for_each = var.iam_roles

  name               = each.value.name
  assume_role_policy = each.value.assume_role_policy

  tags = {
    Name = each.value.name
  }
}

resource "aws_iam_instance_profile" "profiles" {
  for_each = {
    for k, v in var.iam_roles : k => v
    if v.create_instance_profile
  }

  name = each.value.name
  role = aws_iam_role.roles[each.key].name
}

resource "aws_iam_role_policy_attachment" "role_managed" {
  for_each = {
    for item in local.iam_managed_policy_attachments :
    item.key => item
  }

  role       = each.value.role_name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_role_policy" "inline_policies" {
  for_each = {
    for item in local.iam_inline_policies :
    item.key => item
  }

  name   = each.value.policy_name
  role   = each.value.role_name
  policy = each.value.policy
}

resource "aws_iam_policy" "custom" {
  for_each = var.iam_policies

  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = each.value.policy
}

resource "aws_iam_user" "users" {
  for_each = var.iam_users

  name = each.value.name
  tags = {
    Name = each.value.name
  }
}

resource "aws_iam_user_policy" "user_inline" {
  for_each = {
    for item in local.user_inline_policies :
    item.key => item
  }

  name   = each.value.policy_name
  user   = each.value.user_name
  policy = each.value.policy
}

resource "aws_iam_user_policy_attachment" "user_attach" {
  for_each = {
    for k, v in local.iam_policy_attachments :
    k => v
    if v.target_type == "user"
  }

  user       = each.value.target_name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_role_policy_attachment" "role_attach" {
  for_each = {
    for k, v in local.iam_policy_attachments :
    k => v
    if v.target_type == "role"
  }

  role       = each.value.target_name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_group_policy_attachment" "group_attach" {
  for_each = {
    for k, v in local.iam_policy_attachments :
    k => v
    if v.target_type == "group"
  }

  group      = each.value.target_name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_openid_connect_provider" "oidc" {
  for_each = var.oidc_providers

  url             = each.value.url
  client_id_list  = each.value.client_id_list
  thumbprint_list = each.value.thumbprint_list
}
