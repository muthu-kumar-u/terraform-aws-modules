# infra/environments/prod/modules/route53/outputs.tf

output "certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.CertificateValidation.certificate_arn
}

output "certificate_domain_name" {
  description = "Domain name associated with the ACM certificate"
  value       = aws_acm_certificate.CreateACMCert.domain_name
}

output "certificate_status" {
  description = "Status of the ACM certificate"
  value       = aws_acm_certificate.CreateACMCert.status
}
