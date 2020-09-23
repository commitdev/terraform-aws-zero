# Create a route53 zone
# resource "aws_route53_zone" "public" {
#   name = var.domain_name
# }

# Reference an existing route53 zone
data "aws_route53_zone" "public" {
  name = var.zone_name
}

# Create an ACM cert for this domain
resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = var.alternative_names

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  # Change this from a set to a list so we can iterate on it.
  # for_each was not working properly on initial creation
  # https://github.com/terraform-providers/terraform-provider-aws/issues/14447
  validation_records = tolist(aws_acm_certificate.cert.domain_validation_options)
}

# # Route53 record to validate the certificate
resource "aws_route53_record" "cert_validation_record" {
  count = length(local.validation_records)

  name            = local.validation_records[count.index].resource_record_name
  records         = [local.validation_records[count.index].resource_record_value]
  type            = local.validation_records[count.index].resource_record_type
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.public.zone_id
  ttl             = 300
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation_record : record.fqdn]
}
