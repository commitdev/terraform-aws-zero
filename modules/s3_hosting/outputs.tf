output "cloudfront_distribution_id" {
  description = "Identifier of the created cloudfront distribution"
  value       = aws_cloudfront_distribution.client_assets_distribution.id
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.client_assets.arn
}

output "cf_signed_downloads" {
  description = "Does this require signed URL downloads?"
  value       = var.cf_signed_downloads
}
