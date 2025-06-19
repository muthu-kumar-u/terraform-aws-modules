# infra/environments/prod/modules/cloudfront/outputs.tf

output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = module.cdn.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = module.cdn.cloudfront_distribution_arn
}

output "cloudfront_distribution_domain_name" {
  description = "Domain name corresponding to the CloudFront distribution"
  value       = module.cdn.cloudfront_distribution_domain_name
}

output "cloudfront_distribution_status" {
  description = "Status of the CloudFront distribution"
  value       = module.cdn.cloudfront_distribution_status
}
