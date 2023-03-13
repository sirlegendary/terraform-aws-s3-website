provider "aws" {
  region = "eu-west-1"
}

locals {
  project_name     = "project-name"
  source_code_path = "./source_code"
  index_document   = "index.html"
}

resource "random_string" "random" {
  length    = 5
  min_lower = 5
  special   = false
}

module "website" {
  source                = "app.terraform.io/legendary-org/s3-website/aws"
  version               = "0.0.3"
  bucketName            = "${local.project_name}-${resource.random_string.random.id}"
  source_code_directory = local.source_code_path
  index_document        = local.index_document
  sub_domain_name       = "dev"
  domain_name           = "example.com"
}

output "website_url" {
  value = module.website.bucket_domain_name
}

