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

# Route53 record to validate the certificate
resource "aws_route53_record" "cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.public.zone_id
  ttl             = 300
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation_record : record.fqdn]
}
