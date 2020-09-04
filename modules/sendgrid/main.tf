locals {
  sendgrid_endpoint = "https://api.sendgrid.com/v3/"
  cnames = [
    [data.external.sendgrid_route53_cnames.result.dkim1_host, data.external.sendgrid_route53_cnames.result.dkim1_value],
    [data.external.sendgrid_route53_cnames.result.dkim2_host, data.external.sendgrid_route53_cnames.result.dkim2_value],
    [data.external.sendgrid_route53_cnames.result.mail_cname_host, data.external.sendgrid_route53_cnames.result.mail_cname_value]
  ]
}

data "aws_route53_zone" "public" {
  name = var.zone_name
}

## assumes secret is created from zero bootstrap
data "aws_secretsmanager_secret_version" "sendgrid_api_key_secret" {
  secret_id = var.sendgrid_api_key_secret_name
}

# The external data source generates an output that is idempotent,
# and consists of 3 CNAME records [mail_cname/dkim1/dkim2]
# {
#   "domain_id": "9068661",
#   "mail_cname_host": "em4678.mail.get0.dev",
#   "dkim1_host": "s1._domainkey.mail.get0.dev",
#   "dkim2_host": "s2._domainkey.mail.get0.dev",
#   "mail_cname_value": "u18291290.wl041.sendgrid.net",
#   "dkim1_value": "s1.domainkey.u18291290.wl041.sendgrid.net",
#   "dkim2_value": "s2.domainkey.u18291290.wl041.sendgrid.net"
# }
data "external" "sendgrid_route53_cnames" {
  program = ["sh", "${path.module}/sendgrid-external-datasource.sh"]
  query = {
    sendgrid_api_key = data.aws_secretsmanager_secret_version.sendgrid_api_key_secret.secret_string
    sendgrid_domain = "${var.sendgrid_domain_prefix}${var.zone_name}"
  }
}

resource "aws_route53_record" "dns" {
  count = length(local.cnames)

  name            = local.cnames[count.index][0]
  records         = [local.cnames[count.index][1]]
  type            = "CNAME"
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.public.zone_id
  ttl             = 300
}

resource "null_resource" "domain_verification"{
  triggers = {
    domain_id = data.external.sendgrid_route53_cnames.result.domain_id
  }
  provisioner "local-exec" {
    command = "curl -XPOST ${local.sendgrid_endpoint}whitelabel/domains/${data.external.sendgrid_route53_cnames.result.domain_id}/validate -H \"Authorization:Bearer ${data.aws_secretsmanager_secret_version.sendgrid_api_key_secret.secret_string}\""
  }
  depends_on = [aws_route53_record.dns]
}
