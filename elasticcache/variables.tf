# infra/environments/prod/modules/elasticcahe/variables.tf

# General
variable "identifier" {
  description = "Prefix identifier used for naming resources"
  type        = string
}

variable "name" {
  description = "ElastiCache cluster or replication group name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Deployment environment (e.g. dev, prod)"
  type        = string
}

# VPC Configuration
variable "vpc_id" {
  description = "VPC ID where ElastiCache is deployed"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for the subnet group"
  type        = list(string)
}

# Security Group
variable "elasticache_main_security_group_description" {
  description = "Description for ElastiCache security group"
  type        = string
}

variable "lambda_sg_id" {
  description = "Security group ID of the Lambda needing access to ElastiCache"
  type        = string
  default     = null
}

variable "elasticache_security_group_use_name_prefix" {
  description = "Whether to use name prefix for ElastiCache SG"
  type        = bool
  default     = true
}

# ElastiCache Cluster Settings
variable "create_cluster" {
  description = "Whether to create a standalone cluster"
  type        = bool
  default     = false
}

variable "create_replication_group" {
  description = "Whether to create a replication group"
  type        = bool
  default     = true
}

variable "cache_engine" {
  description = "ElastiCache engine (e.g., redis)"
  type        = string
}

variable "cluster_version" {
  description = "ElastiCache engine version"
  type        = string
}

variable "cluster_node_version" {
  description = "Instance type for the cache nodes"
  type        = string
}

variable "apply_immediately" {
  description = "Whether modifications are applied immediately"
  type        = bool
  default     = true
}

# Parameter Group
variable "create_parameter_group" {
  description = "Whether to create a custom parameter group"
  type        = bool
  default     = false
}

variable "parameter_group_family" {
  description = "ElastiCache parameter group family (e.g. redis7)"
  type        = string
}

# Tags for specific keys
variable "cluster_tag_terraform" {
  description = "Tag value to indicate Terraform-managed"
  type        = string
}
