output "route53_zone_id" {
  description = "Identifier of the Route53 Zone"
  value       = data.aws_route53_zone.public.zone_id
}

output "certificate_arn" {
  description = "The ARN of the created certificate"
  value       = aws_acm_certificate.cert.arn
}

output "certificate_validation" {
  description = "The id of the certificate validation. Provided as a dependency so dependents can wait until the cert is actually valid"
  value       = aws_acm_certificate_validation.cert.id
}
