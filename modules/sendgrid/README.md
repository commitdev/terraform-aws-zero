# Sendgrid

Authenticates domain with sendgrid, assumes CNAME required are provided in variables

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements
Assumes domain is already awaiting authentication, this created the route53 entries
then POSTs to verify domain via sendgrid api.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sendgrid_api_key_secret_name | Sendgrid API Key stored in secret manager  | `string` | n/a | yes |
| zone_name | Route53 zone name | `string` | n/a | yes |
| cnames |  | `list(tuple([string, string]))` [record name, value] | `[]` | yes |
| domain_id | The environment (dev/staging/prod) | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
