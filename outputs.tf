output "website_domain" {
  value = aws_s3_bucket_website_configuration.website_bucket_config.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website_bucket_config.website_endpoint
}

output "bucket_domain_name" {
  value = var.domain_name != null ? trimsuffix(aws_s3_bucket.website_bucket_name.bucket_regional_domain_name, ".s3.${data.aws_region.current.name}.amazonaws.com") : "${aws_s3_bucket.website_bucket_name.id}.s3-website.${data.aws_region.current.name}.amazonaws.com"
}