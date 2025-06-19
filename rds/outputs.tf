# infra/environments/prod/modules/rds/outputs.tf

output "rds_instance_arn" {
  description = "ARN of the RDS instance"
  value       = module.rds.db_instance_arn
}

output "rds_instance_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "rds_instance_id" {
  description = "ID of the RDS instance"
  value       = module.rds.db_instance_id
}

output "rds_kms_key_arn" {
  description = "ARN of the KMS key used for RDS encryption"
  value       = aws_kms_key.RDSSecretsKMS.arn
}

output "rds_secret_arn" {
  description = "ARN of the secret stored in Secrets Manager"
  value       = aws_secretsmanager_secret.RDSSecrets.arn
}
