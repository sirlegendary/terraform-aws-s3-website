locals {
  sub_domain_name = var.sub_domain_name != null ? "${var.sub_domain_name}." : ""
  domain_name     = var.domain_name != null ? var.domain_name : ""
  domain          = length("${local.sub_domain_name}${local.domain_name}") > 0 ? "${local.sub_domain_name}${local.domain_name}" : var.bucketName
  mime_types      = jsondecode(file("${path.module}/data/mime.json"))
}