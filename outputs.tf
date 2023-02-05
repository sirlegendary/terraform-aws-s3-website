output "website_url" {
  value = "${aws_s3_bucket.website_bucket_name.id}.s3-website.${var.aws_region}.amazonaws.com"
}

output "website_domain" {
  value = aws_s3_bucket_website_configuration.website_bucket_config.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website_bucket_config.website_endpoint
}

output "routing_rules" {
  value = aws_s3_bucket_website_configuration.website_bucket_config.routing_rules
}

output "bucket_domain_name" {
  value = aws_s3_bucket.website_bucket_name.bucket_domain_name
}
