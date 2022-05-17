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
| database\_engine\_version | Which database version to use. See the aws cli describe-db-engine-versions command for a list of valid versions | `any` | n/a | yes |
| db\_subnet\_group | The subnet group to create dbs in. The default is to use the one created by the vpc module | `string` | `""` | no |
| environment | The environment (stage/prod) | `any` | n/a | yes |
| instance\_class | The AWS instance class of the db | `any` | n/a | yes |
| parameter\_group\_engine\_version | Which parameter group engine version to use. See the aws cli describe-db-engine-versions command for a list of valid versions | `any` | n/a | yes |
| parameter\_group\_family | Which parameter group family to use. See the aws cli describe-db-engine-versions command for a list of valid versions | `any` | n/a | yes |
| parameters | A list of DB parameters to set in a parameter group, passed directly to the underlying module | `list(map(string))` | `[]` | no |
| password\_secret\_suffix | Suffix to add to the secret that will be generated containing the database credentials | `any` | n/a | yes |
| project | The name of the project, mostly for tagging | `any` | n/a | yes |
| storage\_gb | The amount of storage to allocate for the db, in GB | `any` | n/a | yes |
| vpc\_id | The id of the VPC to create the DB in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_endpoint | The internal hostname used to connect to the database |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
