# cache

Create cache store (redis or memcached) cluster

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zones | Availability zone IDs | `list(string)` | `[]` | no |
| cache\_store | Cache store - redis or memcached | `string` | n/a | yes |
| cluster\_size | Number of nodes in cluster | `number` | `1` | no |
| environment | The environment (development/staging/production) | `any` | n/a | yes |
| instance\_type | Elastic cache instance type | `string` | `"cache.t2.micro"` | no |
| memcached\_engine\_version | Engine version | `string` | `"1.5.16"` | no |
| project | Name of the project | `any` | n/a | yes |
| redis\_engine\_version | Engine version | `string` | `"5.0.6"` | no |
| redis\_family | Redis family | `string` | `"redis5.0"` | no |
| security\_groups | The ID of the security group created by default on Default VPC creation | `list(string)` | n/a | yes |
| subnet\_ids | Subnets IDs | `list(string)` | n/a | yes |
| transit\_encryption\_enabled | Enable TLS | `bool` | `true` | no |
| vpc\_id | VPC ID for EKS cluster | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | Cache store address |
| hostname | Cache store hostname |
| id | Cache store ID |
| port | Cache store port |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
