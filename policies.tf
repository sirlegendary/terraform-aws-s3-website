data "aws_iam_policy_document" "s3_website_policy_doc" {
  statement {
    sid     = "PublicReadGetObject"
    effect  = "Allow"
    actions = ["s3:GetObject", ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [
      aws_s3_bucket.website_bucket_name.arn,
      "${aws_s3_bucket.website_bucket_name.arn}/*",
    ]
  }
}