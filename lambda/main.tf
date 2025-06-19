# infra/environments/prod/modules/lambda/main.tf

locals {
  ingress_type = "ingress"
  eggress_type = "egress"
}

# secrets manager access endpoint
resource "aws_vpc_endpoint" "VpcEndpoints" {
  for_each = { for ep in var.vpc_endpoints : ep.name => ep }

  vpc_id              = var.vpc_id
  service_name        = each.value.service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = each.value.subnet_ids
  security_group_ids  = each.value.security_group_ids
  private_dns_enabled = true
  tags = merge(var.tags, {
    Name = each.value.name
  })
}

# lamda security group
resource "aws_security_group" "LambdaSG" {
  name        = "${var.identifier}-sg"
  description = var.lamda_main_security_group_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [for sg in [var.ec2_sg_id, var.rds_sg_id, var.elasticache_sg_id] : sg if sg != null]
    content {
      description     = "Allow inbound from ${ingress.value}"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.identifier}-sg"
  })
}

# lamda -> ec2 (only if ec2_sg_id is provided)
resource "aws_security_group_rule" "LambdaEc2SG" {
  count                    = var.ec2_sg_id != null ? 1 : 0
  type                     = local.ingress_type
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = var.ec2_sg_id
  source_security_group_id = aws_security_group.LambdaSG.id
  description              = var.lambda_ec2_connection_sg_description
}

# lamda -> rds (only if rds_sg_id is provided)
resource "aws_security_group_rule" "LambdaRDSSG" {
  count                    = var.rds_sg_id != null ? 1 : 0
  type                     = local.ingress_type
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = var.rds_sg_id
  source_security_group_id = aws_security_group.LambdaSG.id
  description              = var.lambda_rds_connection_sg_description
}

# lamda -> elastiCache (only if elasticache_sg_id is provided)
resource "aws_security_group_rule" "LambdaElasticcacheSG" {
  count                    = var.elasticache_sg_id != null ? 1 : 0
  type                     = local.ingress_type
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = var.elasticache_sg_id
  source_security_group_id = aws_security_group.LambdaSG.id
  description              = var.lambda_elasticcache_connection_sg_description
}

# lambda iam role create
resource "aws_iam_role" "LambdaRole" {
  name = var.lambda_role_name
  assume_role_policy = jsonencode(var.lambda_role_policy)
}

# custom polices
resource "aws_iam_role_policy" "LambdaGenericPolicy" {
  for_each = {
    for k, v in {
      ses        = var.lamdba_ses_invoke_role_policy
      apigw      = var.lamdba_invoke_api_gateway_role_policy
      fullaccess = var.lamdba_full_access_role_policy
      secrets    = var.lamdba_secrets_manager_role_policy
      vpce       = var.lamdba_vpc_endpoint_access_policy
    } : k => v if v != null
  }

  name   = "${var.identifier}-${each.key}-policy"
  role   = aws_iam_role.LambdaRole.id
  policy = jsonencode(each.value)
}

# policy - cloudwatch logging
resource "aws_iam_role_policy_attachments_exclusive" "LambdaAttachmentPolicies" {
  role_name       = aws_iam_role.LambdaRole.name
  policy_arns     = var.lambda_api_gateway_full_access_policy_attachments
}

# lamdba module
module "lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  description   = var.description
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout
  architectures = var.architectures
  invoke_mode   = var.invoke_mode

  environment_variables = var.environment_variables
  function_tags         = var.tags

  create_role                    = var.create_role
  role_name                      = aws_iam_role.LambdaRole.name
  lambda_role                    = aws_iam_role.LambdaRole.arn

  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = [aws_security_group.LambdaSG.id]
  attach_network_policy = true

  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
}

