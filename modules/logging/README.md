# logging

Create an Elasticsearch cluster using AWS Elasticsearch for storing log data.

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
| create\_service\_role | Set this to false if you already have an existing Elasticsearch cluster in this AWS account | `bool` | n/a | yes |
| ebs\_volume\_size\_in\_gb | Size of EBS volume (in GB) to attach to *each* of the nodes in the cluster. The maximum size is limited by the size of the instance | `number` | n/a | yes |
| elasticsearch\_enforce\_https | Set this to true to disallow unencrypted connections to Elasticsearch on port 80. Disabled by default as we are using kubernetes external services as user-friendly names to allow developers to connect to the cluster through the VPN. This would break if using HTTPS due to certificate issues. | `bool` | `false` | no |
| elasticsearch\_version | Version of elasticsearch to use | `any` | n/a | yes |
| enable\_cluster\_logging | If enabled, sends the logs from the elasticsearch cluster to Cloudwatch | `bool` | `false` | no |
| environment | The environment (dev/staging/prod) | `any` | n/a | yes |
| instance\_count | Number of nodes in the cluster. Must be a multiple of the number of | `number` | n/a | yes |
| instance\_type | Instance type for nodes | `any` | n/a | yes |
| kibana\_subdomain\_name | The name of the subdomain for Kibana in the DNS zone (\_e.g.\_ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`) | `string` | `"kibana"` | no |
| project | The name of the project, mostly for tagging | `any` | n/a | yes |
| security\_groups | Security groups to allow access from | `list(string)` | n/a | yes |
| subnet\_ids | IDs of the subnets to put nodes in. The number of subnets here controls the number of nodes in the cluster, which must be a multiple of this number | `list(string)` | n/a | yes |
| vpc\_id | ID of the VPC to create this cluster in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| elasticsearch\_endpoint | The internal hostname used to connect to Elasticsearch |
| kibana\_endpoint | The URL used to connect to kibana (not including the https scheme) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
