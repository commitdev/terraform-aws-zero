# logging

Create an Elasticsearch cluster using AWS Elasticsearch for storing log data.

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_elasticsearch"></a> [elasticsearch](#module\_elasticsearch) | cloudposse/elasticsearch/aws | 0.44.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.application_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.index_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.search_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.elasticsearch_log_publishing_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_iam_policy_document.elasticsearch_log_publishing_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_service_role"></a> [create\_service\_role](#input\_create\_service\_role) | Set this to false if you already have an existing Elasticsearch cluster in this AWS account | `bool` | n/a | yes |
| <a name="input_ebs_iops"></a> [ebs\_iops](#input\_ebs\_iops) | The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type | `number` | `0` | no |
| <a name="input_ebs_throughput"></a> [ebs\_throughput](#input\_ebs\_throughput) | Specifies the throughput (in MiB/s) of the EBS volumes attached to data nodes. Applicable only for the gp3 volume type. Valid values are between 125 and 1000. | `number` | `null` | no |
| <a name="input_ebs_volume_size_in_gb"></a> [ebs\_volume\_size\_in\_gb](#input\_ebs\_volume\_size\_in\_gb) | Size of EBS volume (in GB) to attach to *each* of the nodes in the cluster. The maximum size is limited by the size of the instance | `number` | n/a | yes |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | Storage type of EBS volumes for data | `string` | `"gp2"` | no |
| <a name="input_elasticsearch_enforce_https"></a> [elasticsearch\_enforce\_https](#input\_elasticsearch\_enforce\_https) | Set this to true to disallow unencrypted connections to Elasticsearch on port 80. Disabled by default as we are using kubernetes external services as user-friendly names to allow developers to connect to the cluster through the VPN. This would break if using HTTPS due to certificate issues. | `bool` | `false` | no |
| <a name="input_elasticsearch_version"></a> [elasticsearch\_version](#input\_elasticsearch\_version) | Version of elasticsearch to use | `any` | n/a | yes |
| <a name="input_enable_cluster_logging"></a> [enable\_cluster\_logging](#input\_enable\_cluster\_logging) | If enabled, sends the logs from the elasticsearch cluster to Cloudwatch | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (stage/prod) | `any` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of nodes in the cluster. Must be a multiple of the number of | `number` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type for nodes | `any` | n/a | yes |
| <a name="input_kibana_subdomain_name"></a> [kibana\_subdomain\_name](#input\_kibana\_subdomain\_name) | The name of the subdomain for Kibana in the DNS zone (\_e.g.\_ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`) | `string` | `"kibana"` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the project, mostly for tagging | `any` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security groups to allow access from | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | IDs of the subnets to put nodes in. The number of subnets here controls the number of nodes in the cluster, which must be a multiple of this number | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC to create this cluster in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elasticsearch_endpoint"></a> [elasticsearch\_endpoint](#output\_elasticsearch\_endpoint) | The internal hostname used to connect to Elasticsearch |
| <a name="output_kibana_endpoint"></a> [kibana\_endpoint](#output\_kibana\_endpoint) | The URL used to connect to kibana (not including the https scheme) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
