locals {
  sendgrid_endpoint = "https://api.sendgrid.com/v3/"
}

## assumed route53 zone is already configured
data "aws_route53_zone" "public" {
  name = var.zone_name
}

resource "aws_route53_record" "dns" {
    count = length(var.cnames)

  name            = var.cnames[count.index][0]
  records         = [var.cnames[count.index][1]]
  type            = "CNAME"
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.public.zone_id
  ttl             = 300
}

## assumes secret is created from zero bootstrap
data "aws_secretsmanager_secret_version" "sendgrid_api_key_secret" {
  secret_id = var.sendgrid_api_key_secret_name
}

resource "null_resource" "domain_verification"{
  triggers = {
    domain_id = var.domain_id
  }
  provisioner "local-exec" {
    command = "curl -XPOST ${local.sendgrid_endpoint}whitelabel/domains/${var.domain_id}/validate -H \"Authorization:Bearer ${data.aws_secretsmanager_secret_version.sendgrid_api_key_secret.secret_string}\""
  }
  depends_on = [aws_route53_record.dns]
}
