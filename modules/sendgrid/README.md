# Sendgrid

Authenticates your domain with sendgrid, assumes Sendgrid API key is available in secret-manager

## Notes
This implementation relies on a bash-script to fetch the CNAMEs required for sendgrid domain authentication, the bashscript must be implemented in an idempotent way where it always returns the same result for terraform state.

## Pre-requisites
- Api key to be stored in AWS secret manager
- HostedZone to be properly configured as root of domain in Route53
- `jq` / `curl` installed

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.13.1 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [null_resource.domain_verification](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_route53_zone.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_secretsmanager_secret_version.sendgrid_api_key_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [external_external.sendgrid_route53_cnames](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sendgrid_api_key_secret_name"></a> [sendgrid\_api\_key\_secret\_name](#input\_sendgrid\_api\_key\_secret\_name) | name of the secret in AWS secret manager that contains the sendgrid API key | `any` | n/a | yes |
| <a name="input_sendgrid_domain_prefix"></a> [sendgrid\_domain\_prefix](#input\_sendgrid\_domain\_prefix) | prefix for mailing domain used by sendgrid | `string` | `""` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | route53 zone for CNAME records to be created | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
