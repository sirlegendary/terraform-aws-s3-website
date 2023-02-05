variable "aws_region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "bucketName" {
  type        = string
  description = "Name of the bucket that will also be the website name"
}

variable "index_document" {
  type        = string
  description = "Suffix for index document"
  default     = "index.html"
}

variable "source_code_directory" {
  type        = string
  description = "Folder containing all the code that needs to be uploaded"
  default     = "./source_code"
}

variable "s3_acl" {
  type        = string
  description = "ACL for S3 object"
  default     = "public-read"
}