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
| alternative\_names | Alternative names to allow for this certificate | `list(string)` | `[]` | no |
| domain\_name | Domain to create an ACM Cert for | `string` | n/a | yes |
| region | The AWS region | `any` | n/a | yes |
| zone\_name | Domains of the Route53 hosted zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_arn | The ARN of the created certificate |
| certificate\_validation | The id of the certificate validation. Provided as a dependency so dependents can wait until the cert is actually valid |
| route53\_zone\_id | Identifier of the Route53 Zone |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
