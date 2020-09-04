# Sendgrid

Authenticates your domain with sendgrid, assumes Sendgrid API key is available in secret-manager

## Notes
This implementation relies on a bash-script to fetch the CNAMEs required for sendgrid domain authentication, the bashscript must be implemented in an idempotent way where it always returns the same result for terraform state.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements
- jq
- curl
- Api key to be stored in AWS secret manager
- HostedZone to be properly configured as root of domain in Route53

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
