# database

Create an RDS database.

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | < 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds_mysql"></a> [rds\_mysql](#module\_rds\_mysql) | terraform-aws-modules/rds/aws | 4.3.0 |
| <a name="module_rds_postgres"></a> [rds\_postgres](#module\_rds\_postgres) | terraform-aws-modules/rds/aws | 4.3.0 |
| <a name="module_rds_security_group"></a> [rds\_security\_group](#module\_rds\_security\_group) | terraform-aws-modules/security-group/aws | 4.9.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_secretsmanager_secret.rds_master_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.rds_master_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_identifier"></a> [additional\_identifier](#input\_additional\_identifier) | An additional string to add to the rds identifier. The final string will look like: <project>-<additional\_identifier><environment> | `string` | `""` | no |
| <a name="input_allowed_security_group_id"></a> [allowed\_security\_group\_id](#input\_allowed\_security\_group\_id) | The security group to allow access | `any` | n/a | yes |
| <a name="input_database_engine"></a> [database\_engine](#input\_database\_engine) | Which database engine to use, currently supports `postgres` or `mysql` | `any` | n/a | yes |
| <a name="input_database_engine_version"></a> [database\_engine\_version](#input\_database\_engine\_version) | Which database version to use. See the aws cli describe-db-engine-versions command for a list of valid versions | `any` | n/a | yes |
| <a name="input_db_subnet_group"></a> [db\_subnet\_group](#input\_db\_subnet\_group) | The subnet group to create dbs in. The default is to use the one created by the vpc module | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (stage/prod) | `any` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The AWS instance class of the db | `any` | n/a | yes |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| <a name="input_parameter_group_engine_version"></a> [parameter\_group\_engine\_version](#input\_parameter\_group\_engine\_version) | Which parameter group engine version to use. See the aws cli describe-db-engine-versions command for a list of valid versions | `any` | n/a | yes |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | Which parameter group family to use. See the aws cli describe-db-engine-versions command for a list of valid versions | `any` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A list of DB parameters to set in a parameter group, passed directly to the underlying module | `list(map(string))` | `[]` | no |
| <a name="input_password_secret_suffix"></a> [password\_secret\_suffix](#input\_password\_secret\_suffix) | Suffix to add to the secret that will be generated containing the database credentials | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The name of the project, mostly for tagging | `any` | n/a | yes |
| <a name="input_replicate_from_db_id"></a> [replicate\_from\_db\_id](#input\_replicate\_from\_db\_id) | Set this to the ID of a database to replicate from. If set, the database will be created as a read replica of the specified database | `any` | `null` | no |
| <a name="input_storage_gb"></a> [storage\_gb](#input\_storage\_gb) | The amount of storage to allocate for the db, in GB | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of the VPC to create the DB in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_endpoint"></a> [database\_endpoint](#output\_database\_endpoint) | The internal hostname used to connect to the database |
| <a name="output_database_id"></a> [database\_id](#output\_database\_id) | The instance id of the database |
| <a name="output_database_security_group_id"></a> [database\_security\_group\_id](#output\_database\_security\_group\_id) | The id of the created security group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
