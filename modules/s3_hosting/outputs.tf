output "cloudfront_distribution_id" {
  description = "Identifier of the created cloudfront distribution"
  value       = aws_cloudfront_distribution.client_assets_distribution.id
}
