resource "aws_s3_bucket" "website_bucket_name" {
  bucket = local.domain
}

resource "aws_s3_bucket_website_configuration" "website_bucket_config" {
  bucket = aws_s3_bucket.website_bucket_name.bucket

  index_document {
    suffix = var.index_document
  }
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket_name.id
  policy = data.aws_iam_policy_document.s3_website_policy_doc.json
}

resource "aws_s3_object" "website_upload" {
  for_each = fileset("${var.source_code_directory}/", "**")

  bucket       = aws_s3_bucket.website_bucket_name.id
  key          = each.value
  source       = "${var.source_code_directory}/${each.value}"
  acl          = var.s3_acl
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)
}