# infra/environments/prod/modules/api_gateway/variables.tf

variable "name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "description" {
  description = "Description of the API Gateway"
  type        = string
  default     = "Managed by Terraform"
}

variable "protocol_type" {
  description = "Protocol type for the API Gateway (HTTP or WEBSOCKET)"
  type        = string
  default     = "HTTP"
}

# CORS settings
variable "cors_allow_headers" {
  description = "List of allowed headers for CORS"
  type        = list(string)
  default     = ["*"]
}

variable "cors_allow_methods" {
  description = "List of allowed methods for CORS"
  type        = list(string)
  default     = ["GET", "POST", "OPTIONS"]
}

variable "cors_allow_origins" {
  description = "List of allowed origins for CORS"
  type        = list(string)
  default     = ["*"]
}

# Logging
variable "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group for access logs"
  type        = string
}

variable "access_log_format" {
  description = "Format for access logs"
  type        = string
}

# Domain name configuration
variable "domain_name" {
  description = "Custom domain name for the API Gateway"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate for the custom domain"
  type        = string
}

# Integration
variable "lambda_arn" {
  description = "ARN of the Lambda function to integrate with API Gateway"
  type        = string
}

# Tags
variable "tags" {
  description = "Tags to apply to API Gateway resources"
  type        = map(string)
  default     = {}
}
