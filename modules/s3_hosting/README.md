# s3_hosting

Create an S3 bucket and Cloudfront distribution for holding frontend application assets.

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aliases | Additional domains that this cloudfront distribution will serve traffic for | `list(string)` | n/a | yes |
| certificate\_arn | ARN of the certificate to use for this cloudfront distribution | `string` | n/a | yes |
| cf\_signed\_downloads | Enable Cloudfront signed URLs | `bool` | `false` | no |
| domain | Domain to host content for. This will be the name of the bucket | `string` | n/a | yes |
| environment | The environment (dev/stage/prod) | `any` | n/a | yes |
| project | The name of the project, mostly for tagging | `any` | n/a | yes |
| route53\_zone\_id | ID of the Route53 zone to create a record in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloudfront\_distribution\_id | Identifier of the created cloudfront distribution |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
