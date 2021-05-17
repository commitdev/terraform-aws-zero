output "cloudfront_distribution_id" {
  description = "Identifier of the created cloudfront distribution"
  value       = aws_cloudfront_distribution.client_assets_distribution.id
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = data.aws_s3_bucket.client_assets.arn
}

output "cf_signing_enabled" {
  description = "Does this require signed URL downloads?"
  value       = var.cf_signed_downloads
}

output "cf_origin_assets_access_identity_arn" {
  description = "Cloudfront origin assets access identity, useful when multiple CF using the same bucket to manage S3 bucket policies"
  value       = aws_cloudfront_origin_access_identity.client_assets.iam_arn
}
