data "aws_route53_zone" "selected" {
  count = var.domain_name != null ? 1 : 0

  name = "${var.domain_name}."
}

# resource "aws_route53_zone" "domain_name" {
#   count = var.domain_name != null ? 1 : 0

#   name = var.domain_name
# }

resource "aws_route53_record" "domain_name_record" {
  count = var.domain_name != null ? 1 : 0

  zone_id = data.aws_route53_zone.selected[count.index].zone_id
  name    = var.sub_domain_name != null ? var.sub_domain_name : var.domain_name
  type    = "A"
  alias {
    name                   = aws_s3_bucket_website_configuration.website_bucket_config.website_domain
    zone_id                = aws_s3_bucket.website_bucket_name.hosted_zone_id
    evaluate_target_health = true
  }
}