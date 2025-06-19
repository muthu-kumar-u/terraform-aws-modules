# infra/environments/prod/modules/route53/variables.tf

variable "acm_certificate_domain" {
  description = "Primary domain for the ACM certificate"
  type        = string
}

variable "acm_san_names" {
  description = "Subject Alternative Names for the ACM certificate"
  type        = list(string)
  default     = []
}

variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID for DNS validation"
  type        = string
}

variable "tags" {
  description = "Tags to apply to ACM certificate and Route53 records"
  type        = map(string)
  default     = {}
}
