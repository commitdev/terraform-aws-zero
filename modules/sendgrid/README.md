# Sendgrid

Authenticates your domain with sendgrid, assumes Sendgrid API key is available in secret-manager

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements
Api key to be stored in AWS secret manager
HostedZone to be properly configured as root of domain in Route53

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| zone_name | Route53 zone name | `string` | n/a | yes |
| sendgrid_api_key_secret_name | Sendgrid API Key stored in secret manager  | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
