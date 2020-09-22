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
  count = length(var.domain_names)

  domain_name       = var.domain_names[count.index]
  validation_method = "DNS"
}

# Route53 record to validate the certificate
resource "aws_route53_record" "cert_validation_record" {
  count = length(aws_acm_certificate.cert)

  name            = aws_acm_certificate.cert[count.index].domain_validation_options[0]["resource_record_name"]
  records         = [aws_acm_certificate.cert[count.index].domain_validation_options[0]["resource_record_value"]]
  type            = "CNAME"
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.public.zone_id
  ttl             = 300
}

resource "aws_acm_certificate_validation" "cert" {
  count = length(aws_acm_certificate.cert)

  certificate_arn         = aws_acm_certificate.cert[count.index].arn
  validation_record_fqdns = aws_route53_record.cert_validation_record.*.fqdn
}
