# infra/environments/prod/modules/lambda/variables.tf

# General Lambda Config
variable "identifier" {
  description = "Prefix identifier for naming resources"
  type        = string
}

variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "description" {
  description = "Lambda function description"
  type        = string
}

variable "handler" {
  description = "Lambda handler"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime environment (e.g., nodejs18.x, python3.11)"
  type        = string
}

variable "memory_size" {
  description = "Memory size in MB"
  type        = number
}

variable "timeout" {
  description = "Function timeout in seconds"
  type        = number
}

variable "architectures" {
  description = "Instruction set architecture (e.g., x86_64, arm64)"
  type        = list(string)
  default     = ["x86_64"]
}

variable "invoke_mode" {
  description = "Lambda invoke mode (e.g., BUFFERED, RESPONSE_STREAM)"
  type        = string
  default     = "BUFFERED"
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

# VPC Configuration
variable "vpc_id" {
  description = "VPC ID to attach Lambda and endpoints"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "List of subnet IDs for the Lambda function"
  type        = list(string)
}

# VPC Endpoints
variable "vpc_endpoints" {
  description = <<EOT
List of maps describing VPC interface endpoints to create.
Each object requires: {
  name              = string
  service_name      = string
  subnet_ids        = list(string)
  security_group_ids = list(string)
}
EOT
  type = list(object({
    name               = string
    service_name       = string
    subnet_ids         = list(string)
    security_group_ids = list(string)
  }))
  default = []
}

# Security Group Connections
variable "lamda_main_security_group_description" {
  description = "Security group description for Lambda"
  type        = string
}

variable "ec2_sg_id" {
  description = "Security group ID of EC2 to allow access from Lambda"
  type        = string
  default     = null
}

variable "rds_sg_id" {
  description = "Security group ID of RDS to allow access from Lambda"
  type        = string
  default     = null
}

variable "elasticache_sg_id" {
  description = "Security group ID of ElastiCache to allow access from Lambda"
  type        = string
  default     = null
}

variable "lambda_ec2_connection_sg_description" {
  description = "Description for Lambda to EC2 security group rule"
  type        = string
  default     = "Lambda to EC2 connection"
}

variable "lambda_rds_connection_sg_description" {
  description = "Description for Lambda to RDS security group rule"
  type        = string
  default     = "Lambda to RDS connection"
}

variable "lambda_elasticcache_connection_sg_description" {
  description = "Description for Lambda to ElastiCache security group rule"
  type        = string
  default     = "Lambda to ElastiCache connection"
}

# IAM Role
variable "create_role" {
  description = "Whether to create a new IAM role"
  type        = bool
}

variable "lambda_role_name" {
  description = "IAM role name for the Lambda function"
  type        = string
}

variable "lambda_role_policy" {
  description = "IAM trust policy document for the Lambda role"
  type        = any
}

variable "lamdba_ses_invoke_role_policy" {
  description = "Policy for allowing SES access"
  type        = any
  default     = null
}

variable "lamdba_invoke_api_gateway_role_policy" {
  description = "Policy for invoking API Gateway"
  type        = any
  default     = null
}

variable "lamdba_full_access_role_policy" {
  description = "Full access policy"
  type        = any
  default     = null
}

variable "lamdba_secrets_manager_role_policy" {
  description = "Policy to access AWS Secrets Manager"
  type        = any
  default     = null
}

variable "lamdba_vpc_endpoint_access_policy" {
  description = "Policy to access VPC endpoints"
  type        = any
  default     = null
}

variable "lambda_api_gateway_full_access_policy_attachments" {
  description = "List of policy ARNs to attach to Lambda role"
  type        = list(string)
  default     = []
}

# Logging
variable "cloudwatch_logs_retention_in_days" {
  description = "CloudWatch logs retention period in days"
  type        = number
  default     = 7
}
