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
| allowed\_cors\_origins | a list of CORS origins domains allowed to access the S3 bucket | `list(string)` | `[]` | no |
| certificate\_arn | ARN of the certificate to use for this cloudfront distribution | `string` | n/a | yes |
| certificate\_validation | Id of the certificate validation record for the provided cert. Used to create a dependency so we don't use the cert before it is ready | `string` | n/a | yes |
| cf\_lambda\_function\_associations | A config block that triggers a lambda function with specific actions (maximum 4) | <pre>list(object({<br>    event_type   = string<br>    lambda_arn   = string<br>    include_body = bool<br>  }))</pre> | `[]` | no |
| cf\_signed\_downloads | Enable Cloudfront signed URLs | `bool` | `false` | no |
| cf\_trusted\_signers | Only available when cf\_signed\_downloads is enabled, a list of trusted signers(self/account\_id) for Cloudfront, used for signing URLs | `list(string)` | <pre>[<br>  "self"<br>]</pre> | no |
| create\_s3\_bucket\_policy | Useful when multiple CF using the same bucket, then you may want to create the S3 Bucket policy manually to allow mulltiple principals | `bool` | `true` | no |
| domain | Domain to host content for. This will be the name of the bucket | `string` | n/a | yes |
| environment | The environment (stage/prod) | `any` | n/a | yes |
| project | The name of the project, mostly for tagging | `any` | n/a | yes |
| route53\_zone\_id | ID of the Route53 zone to create a record in | `string` | n/a | yes |
| use\_existing\_s3\_bucket | Name of existing s3 Bucket to use instead of creating a new one | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | ARN of the created S3 bucket |
| cf\_origin\_assets\_access\_identity\_arn | Cloudfront origin assets access identity, useful when multiple CF using the same bucket to manage S3 bucket policies. |
| cf\_signing\_enabled | Does this require signed URL downloads? |
| cloudfront\_distribution\_id | Identifier of the created cloudfront distribution |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
