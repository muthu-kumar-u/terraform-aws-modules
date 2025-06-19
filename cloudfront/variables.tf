# infra/environments/prod/modules/cloudfront/variables.tf

# General settings
variable "cloudfront_aliases" {
  description = "Alternate domain names (CNAMEs) for the distribution"
  type        = list(string)
  default     = []
}

variable "cloudfront_comment" {
  description = "Any comments to describe the distribution"
  type        = string
  default     = "Managed by Terraform"
}

variable "cloudfront_enabled" {
  description = "Whether the distribution is enabled to accept user requests"
  type        = bool
  default     = true
}

variable "cloudfront_is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution"
  type        = bool
  default     = true
}

variable "cloudfront_price_class" {
  description = "Price class for CloudFront distribution"
  type        = string
  default     = "PriceClass_100"
}

variable "cloudfront_retain_on_delete" {
  description = "Retain the distribution on destroy"
  type        = bool
  default     = false
}

variable "cloudfront_wait_for_deployment" {
  description = "Whether to wait for the distribution deployment"
  type        = bool
  default     = true
}

# Origin Access Identity
variable "create_origin_access_identity" {
  description = "Whether to create an origin access identity"
  type        = bool
  default     = true
}

variable "origin_access_identity_description" {
  description = "Description for the origin access identity"
  type        = string
}

# Origin settings
variable "static_bucket_url" {
  description = "Domain name of the S3 static bucket origin"
  type        = string
}

# Default Cache Behavior
variable "default_target_origin_id" {
  description = "Origin ID to use for the default cache behavior"
  type        = string
}

variable "default_viewer_protocol_policy" {
  description = "Viewer protocol policy for default behavior"
  type        = string
  default     = "redirect-to-https"
}

variable "default_allowed_methods" {
  description = "Allowed HTTP methods for default behavior"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "default_cached_methods" {
  description = "Cached HTTP methods for default behavior"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "default_compress" {
  description = "Whether to enable compression for default behavior"
  type        = bool
  default     = true
}

variable "default_query_string" {
  description = "Whether to forward query strings for default behavior"
  type        = bool
  default     = false
}

# Ordered Cache Behavior
variable "static_path_pattern" {
  description = "Path pattern for ordered cache behavior"
  type        = string
}

variable "static_target_origin_id" {
  description = "Origin ID for static content cache behavior"
  type        = string
}

variable "static_viewer_protocol_policy" {
  description = "Viewer protocol policy for static path"
  type        = string
  default     = "redirect-to-https"
}

variable "static_allowed_methods" {
  description = "Allowed HTTP methods for static path"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "static_cached_methods" {
  description = "Cached HTTP methods for static path"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "static_compress" {
  description = "Whether to enable compression for static content"
  type        = bool
  default     = true
}

variable "static_query_string" {
  description = "Whether to forward query strings for static content"
  type        = bool
  default     = false
}

# TLS/SSL
variable "viewer_certificate_arn" {
  description = "ACM certificate ARN for HTTPS support"
  type        = string
}

variable "ssl_support_method" {
  description = "SSL support method for CloudFront"
  type        = string
  default     = "sni-only"
}

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
