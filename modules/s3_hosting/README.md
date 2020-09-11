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
| buckets | S3 hosting buckets | `set(string)` | n/a | yes |
| certificate\_arns | ARN of the certificate we created for the assets domain, keyed by domain | `map` | n/a | yes |
| cf\_signed\_downloads | Enable Cloudfront signed URLs | `bool` | `false` | no |
| environment | The environment (dev/staging/prod) | `any` | n/a | yes |
| project | The name of the project, mostly for tagging | `any` | n/a | yes |
| route53\_zone\_id | ID of the Route53 zone to create a record in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloudfront\_distribution\_ids | Identifiers of the created cloudfront distributions |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
