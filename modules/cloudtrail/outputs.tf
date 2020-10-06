# output for cloudtrail module
output "cloudtrail_id" {
  value       = join("", aws_cloudtrail.this.*.id)
  description = "The name of the trail"
}

output "cloudtrail_arn" {
  value       = join("", aws_cloudtrail.this.*.arn)
  description = "The Amazon Resource Name of the trail"
}

output "cloudtrail_bucket_id" {
  value       = aws_s3_bucket.cloudtrail.id
  description = "The bucket ID of the trail"
}
