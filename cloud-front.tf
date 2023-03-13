# PriceClass: Europe & North America (United States, Mexico, Canada)
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html

resource "aws_cloudfront_distribution" "website_cdn_root" {
  count = var.domain_name != null ? 1 : 0

  enabled     = true
  price_class = "PriceClass_100"
  aliases     = [var.domain_name, "www.${var.domain_name}", aws_s3_bucket.website_bucket_name.bucket]
  provider    = aws.us-east-1

  origin {
    domain_name = aws_s3_bucket_website_configuration.website_bucket_config.website_endpoint

    origin_id = aws_s3_bucket_website_configuration.website_bucket_config.website_endpoint

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_root_object = var.index_document

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket_website_configuration.website_bucket_config.website_endpoint
    min_ttl          = "0"
    default_ttl      = "20"
    max_ttl          = "1200"

    viewer_protocol_policy = "redirect-to-https" # Redirects any HTTP request to HTTPS
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert[0].arn
    ssl_support_method  = "sni-only"
  }

  lifecycle {
    ignore_changes = [
      viewer_certificate,
    ]
  }

  tags = {
    ManagedBy = "Terraform"
  }

  depends_on = [aws_acm_certificate_validation.cert_validation]
}