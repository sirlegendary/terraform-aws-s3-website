data "aws_route53_zone" "selected" {
  count = var.domain_name != null ? 1 : 0

  name = "${local.trimmed_domain}."
}

resource "aws_route53_record" "cert_dns" {
  for_each = {
    for dvo in aws_acm_certificate.cert[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  zone_id         = data.aws_route53_zone.selected[0].zone_id
  records         = [each.value.record]
  ttl             = 60
}

resource "aws_route53_record" "domain_name_record" {
  count = var.domain_name != null ? 1 : 0

  zone_id = data.aws_route53_zone.selected[count.index].zone_id
  name    = var.sub_domain_name != null ? var.sub_domain_name : var.domain_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.website_cdn_root[0].domain_name
    zone_id                = aws_cloudfront_distribution.website_cdn_root[0].hosted_zone_id
    evaluate_target_health = true
  }
}