# infra/environments/prod/modules/route53/main.tf

# create acm certificate for the given domain
resource "aws_acm_certificate" "CreateACMCert" {
  domain_name       = var.acm_certificate_domain
  validation_method = "DNS"

  subject_alternative_names = var.acm_san_names

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.tags, {
    Name = "acm-cert-${var.acm_certificate_domain}"
  })
}

# DNS validation using Route 53
resource "aws_route53_record" "CreateRecord" {
  for_each = {
    for dvo in aws_acm_certificate.CreateACMCert.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
      zone_id = var.route53_zone_id
    }
  }

  zone_id = each.value.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}

# certificate validation
resource "aws_acm_certificate_validation" "CertificateValidation" {
  certificate_arn = aws_acm_certificate.CreateACMCert.arn

  validation_record_fqdns = [
    for record in aws_route53_record.CreateRecord : record.fqdn
  ]
}