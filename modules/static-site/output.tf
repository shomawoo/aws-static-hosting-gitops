output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.cdn.domain_name
  description = "The public URL to access the deployed website"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.site_bucket.id
}