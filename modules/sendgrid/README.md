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

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| external | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sendgrid\_api\_key\_secret\_name | name of the secret in AWS secret manager that contains the sendgrid API key | `any` | n/a | yes |
| sendgrid\_domain\_prefix | prefix for mailing domain used by sendgrid | `string` | `""` | no |
| zone\_name | route53 zone for CNAME records to be created | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
