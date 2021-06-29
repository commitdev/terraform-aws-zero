# certificate

Create and validate ACM certificates.

## Notes

This module requires an aws provider in the **us-east-1** region to be passed in if the certificate is being used for CloudFront.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.37.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.37.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alternative\_names | Alternative names to allow for this certificate | `list(string)` | `[]` | no |
| domain\_name | Domain to create an ACM Cert for | `string` | n/a | yes |
| zone\_name | Domains of the Route53 hosted zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_arn | The ARN of the created certificate |
| certificate\_validation | The id of the certificate validation. Provided as a dependency so dependents can wait until the cert is actually valid |
| route53\_zone\_id | Identifier of the Route53 Zone |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
