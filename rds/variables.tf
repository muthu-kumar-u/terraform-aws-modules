# infra/environments/prod/modules/rds/variables.tf

# General
variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# VPC and Networking
variable "vpc_id" {
  description = "VPC ID where RDS resides"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "lambda_sg_id" {
  description = "Security Group ID of the Lambda function for allowing access to RDS"
  type        = string
  default     = null
}

# Security Group
variable "rds_main_security_group_description" {
  description = "Description for the RDS main security group"
  type        = string
}

# IAM Monitoring Role
variable "monitoring_role_name" {
  description = "Name of the IAM role used for enhanced monitoring"
  type        = string
}

variable "assume_role_policy" {
  description = "IAM assume role policy JSON for RDS monitoring role"
  type        = string
}

variable "monitoring_role_description" {
  description = "Description of the monitoring IAM role"
  type        = string
}

variable "rds_role_policy_attachment" {
  description = "Policy ARN to attach to the RDS monitoring IAM role"
  type        = string
}

variable "monitoring_role_use_name_prefix" {
  description = "Use name prefix for monitoring IAM role"
  type        = bool
  default     = false
}

# KMS and Secrets Manager
variable "rds_kms_key_main_description" {
  description = "Description for the RDS KMS key"
  type        = string
}

variable "rds_kms_key_deletion_window" {
  description = "KMS deletion window in days"
  type        = number
}

variable "rds_rotation_period" {
  description = "KMS key rotation period in days"
  type        = number
}

variable "rds_enable_key_rotation" {
  description = "Enable KMS key rotation"
  type        = bool
}

# RDS DB config
variable "engine" {
  description = "The database engine (e.g. postgres, mysql)"
  type        = string
}

variable "engine_version" {
  description = "The engine version"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
}

variable "storage_encrypted" {
  description = "Whether to enable storage encryption"
  type        = bool
}

variable "apply_immediately" {
  description = "Whether to apply changes immediately"
  type        = bool
}

variable "availability_zone" {
  description = "AZ where the RDS instance will be deployed"
  type        = string
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
}

variable "ca_cert_identifier" {
  description = "Identifier of the CA certificate for the DB instance"
  type        = string
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Retention days for CloudWatch logs"
  type        = number
}

variable "create_cloudwatch_log_group" {
  description = "Create CloudWatch log group"
  type        = bool
}

variable "deletion_protection" {
  description = "Enable deletion protection for the RDS instance"
  type        = bool
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage"
  type        = number
}

variable "storage_type" {
  description = "Storage type (gp2, gp3, etc.)"
  type        = string
}

variable "monitoring_interval" {
  description = "Monitoring interval in seconds (0 to disable)"
  type        = number
}

# Credentials
variable "username" {
  description = "Master DB username"
  type        = string
}

variable "password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the initial database"
  type        = string
}

variable "port" {
  description = "Port the DB instance listens on"
  type        = number
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Whether to skip final snapshot before deletion"
  type        = bool
}

variable "manage_master_user_password_rotation" {
  description = "Enable automatic password rotation"
  type        = bool
}

variable "master_user_password_rotation_automatically_after_days" {
  description = "Password rotation frequency (in days)"
  type        = number
}
