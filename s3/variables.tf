# infra/environments/prod/modules/s3/variables.tf

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "acl_mode" {
  description = "Canned ACL to apply"
  type        = string
  default     = "private"
}

variable "block_public_acls" {
  description = "Whether Amazon S3 blocks public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 blocks public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 ignores public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 restricts public bucket policies"
  type        = bool
  default     = true
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "bucket_key_enabled" {
  description = "Whether bucket key is enabled for SSE-KMS"
  type        = bool
  default     = true
}

variable "object_lock_enabled" {
  description = "Enable object lock for the S3 bucket"
  type        = bool
  default     = false
}

variable "cloudfront_arn" {
  description = "CloudFront distribution ARN to allow access from"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
