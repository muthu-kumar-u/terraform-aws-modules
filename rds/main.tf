# infra/environments/prod/modules/rds/main.tf

# rds role
resource "aws_iam_role" "RDSMonitoringRole" {
  name               = var.monitoring_role_name
  assume_role_policy = var.assume_role_policy
  description        = var.monitoring_role_description
  tags               = var.tags
}

# rds role attachment
resource "aws_iam_role_policy_attachment" "RDSMonitoringRolePolicyAttachment" {
  role       = aws_iam_role.RDSMonitoringRole.name
  policy_arn = var.rds_role_policy_attachment
}

# rds security group
resource "aws_security_group" "RDSSG" {
  name        = "${var.identifier}-sg"
  description = var.rds_main_security_group_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.lambda_sg_id != null ? [var.lambda_sg_id] : []
    content {
      description     = var.rds_main_security_group_description
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

# rds subnet group
resource "aws_db_subnet_group" "RDSSubnetGroup" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

# kms key create
resource "aws_kms_key" "RDSSecretsKMS" {
  description = var.rds_kms_key_main_description
  deletion_window_in_days = var.rds_kms_key_deletion_window
  rotation_period_in_days = var.rds_rotation_period
  enable_key_rotation = var.rds_enable_key_rotation
  tags = var.tags
}

# rds secrets manager
resource "aws_secretsmanager_secret" "RDSSecrets" {
  name = "${var.identifier}-credentials"
  kms_key_id = aws_kms_key.RDSSecretsKMS.arn
  tags = var.tags
}

# rds secrets manager version handling
resource "aws_secretsmanager_secret_version" "RDSSecretsVersion" {
  secret_id     = aws_secretsmanager_secret.RDSSecrets.id
}

# rds module
module "rds" {
  source  = "terraform-aws-modules/rds/aws"

  identifier           = var.identifier
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  storage_encrypted    = var.storage_encrypted
  kms_key_id           = aws_kms_key.RDSSecretsKMS.id
  apply_immediately    = var.apply_immediately
  availability_zone    = var.availability_zone
  backup_retention_period = var.backup_retention_period
  ca_cert_identifier   = var.ca_cert_identifier
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  create_cloudwatch_log_group = var.create_cloudwatch_log_group
  deletion_protection = var.deletion_protection
  max_allocated_storage = var.max_allocated_storage
  monitoring_role_arn = aws_iam_role.RDSMonitoringRole.arn
  monitoring_role_description = var.monitoring_role_description
  monitoring_role_use_name_prefix = var.monitoring_role_use_name_prefix
  storage_type = var.storage_type
  subnet_ids = var.subnet_ids

  db_name              = var.db_name
  manage_master_user_password = false
  manage_master_user_password_rotation = var.manage_master_user_password_rotation
  master_user_password_rotation_automatically_after_days = var.master_user_password_rotation_automatically_after_days
  username             = var.username
  password             = var.password
  publicly_accessible = var.publicly_accessible

  port                 = var.port
  multi_az             = var.multi_az
  db_subnet_group_name = aws_db_subnet_group.RDSSubnetGroup.name
  vpc_security_group_ids = [aws_security_group.RDSSG.id]

  monitoring_interval  = var.monitoring_interval
  monitoring_role_name = var.monitoring_role_name
  create_monitoring_role = false
  skip_final_snapshot = var.skip_final_snapshot
  snapshot_identifier = "${var.identifier}-final-snapshot"

  tags                 = var.tags
}
