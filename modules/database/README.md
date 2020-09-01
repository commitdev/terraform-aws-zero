# database

Create an RDS database.

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
| allowed\_security\_group\_id | The security group to allow access | `any` | n/a | yes |
| database\_engine | Which database engine to use, currently supports `postgres` or `mysql` | `any` | n/a | yes |
| environment | The environment (development/staging/production) | `any` | n/a | yes |
| instance\_class | The AWS instance class of the db | `any` | n/a | yes |
| password\_secret\_suffix | Suffix to add to the secret that will be generated containing the database credentials | `any` | n/a | yes |
| project | The name of the project, mostly for tagging | `any` | n/a | yes |
| storage\_gb | The amount of storage to allocate for the db, in GB | `any` | n/a | yes |
| vpc\_id | The id of the VPC to create the DB in | `any` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
