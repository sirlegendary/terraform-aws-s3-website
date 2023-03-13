resource "aws_acm_certificate" "cert" {
  count = var.domain_name != null ? 1 : 0

  provider                  = aws.us-east-1
  domain_name               = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}", "*.${var.domain_name}"]
  validation_method         = "DNS"

  tags = {
    ManagedBy = "Terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  count = var.domain_name != null ? 1 : 0

  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cert_dns : record.fqdn]
}