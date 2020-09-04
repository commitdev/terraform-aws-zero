# certificate

Create and validate ACM certificates.

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.custom | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain\_names | Domains to create an ACM Cert for | `list(string)` | n/a | yes |
| region | The AWS region | `any` | n/a | yes |
| zone\_name | Domains of the Route53 hosted zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_arns | The ARNs of the created certificates, keyed by domain name |
| certificate\_validations | The ids of the certificate validations. Provided as a dependency so dependents can wait until the cert is actually valid |
| route53\_zone\_id | Identifier of the Route53 Zone |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
