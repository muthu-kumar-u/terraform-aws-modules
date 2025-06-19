# infra/environments/prod/modules/s3/outputs.tf

output "bucket_id" {
  description = "ID of the created S3 bucket"
  value       = module.s3_bucket.s3_bucket_id
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = module.s3_bucket.s3_bucket_arn
}

output "bucket_domain_name" {
  description = "Domain name of the created S3 bucket"
  value       = module.s3_bucket.s3_bucket_bucket_domain_name
}
