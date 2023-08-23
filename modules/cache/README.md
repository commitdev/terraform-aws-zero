# cache

Create cache store (redis or memcached) cluster

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_memcached"></a> [memcached](#module\_memcached) | cloudposse/elasticache-memcached/aws | 0.15.1 |
| <a name="module_redis"></a> [redis](#module\_redis) | cloudposse/elasticache-redis/aws | 0.51.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zone IDs | `list(string)` | `[]` | no |
| <a name="input_cache_store"></a> [cache\_store](#input\_cache\_store) | Cache store - redis or memcached | `string` | n/a | yes |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of nodes in cluster | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (stage/prod) | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Elastic cache instance type | `string` | `"cache.t2.micro"` | no |
| <a name="input_memcached_engine_version"></a> [memcached\_engine\_version](#input\_memcached\_engine\_version) | Engine version | `string` | `"1.5.16"` | no |
| <a name="input_project"></a> [project](#input\_project) | Name of the project | `any` | n/a | yes |
| <a name="input_redis_engine_version"></a> [redis\_engine\_version](#input\_redis\_engine\_version) | Engine version | `string` | `"5.0.6"` | no |
| <a name="input_redis_family"></a> [redis\_family](#input\_redis\_family) | Redis family | `string` | `"redis5.0"` | no |
| <a name="input_redis_transit_encryption_enabled"></a> [redis\_transit\_encryption\_enabled](#input\_redis\_transit\_encryption\_enabled) | Enable TLS for redis | `bool` | `true` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The ID of the security group created by default on Default VPC creation | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnets IDs | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for EKS cluster | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Cache store address |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | Cache store hostname |
| <a name="output_id"></a> [id](#output\_id) | Cache store ID |
| <a name="output_port"></a> [port](#output\_port) | Cache store port |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
