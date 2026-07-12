variable "bucket_name" {
  type        = string
  description = "The base name of the S3 bucket"
}

variable "environment" {
  type        = string
  description = "The deployment environment (e.g., dev, prod)"
}