output "cloudfront_distribution_id" {
  description = "Identifier of the created cloudfront distribution"
  value       = aws_cloudfront_distribution.client_assets_distribution.id
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.client_assets.arn
}
