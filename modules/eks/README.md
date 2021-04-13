# eks

Create a Kubernetes cluster using EKS.

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
| cluster\_name | Name to be given to the EKS cluster | `any` | n/a | yes |
| cluster\_version | EKS cluster version number to use. Incrementing this will start a cluster upgrade | `any` | n/a | yes |
| environment | The environment (stage/prod) | `any` | n/a | yes |
| iam\_account\_id | Account ID of the current IAM user | `any` | n/a | yes |
| iam\_role\_mapping | List of mappings of AWS Roles to Kubernetes Groups | <pre>list(object({<br>    iam_role_arn  = string<br>    k8s_role_name = string<br>    k8s_groups    = list(string)<br>  }))</pre> | n/a | yes |
| private\_subnets | VPC subnets for the EKS cluster | `list(string)` | n/a | yes |
| project | Name of the project | `any` | n/a | yes |
| use\_spot\_instances | Enable use of spot instances instead of on-demand. This can provide significant cost savings and should be stable due to the use of the termination handler, but means that individuial nodes could be restarted at any time. May not be suitable for clusters with long-running workloads | `bool` | `false` | no |
| vpc\_id | VPC ID for EKS cluster | `any` | n/a | yes |
| worker\_ami\_type | AMI type for the EKS worker instances. The default will be the normal image. Other possibilities are AL2\_x86\_64\_GPU for gpu instances or AL2\_ARM\_64 for ARM instances | `string` | `"AL2_x86_64"` | no |
| worker\_asg\_max\_size | Maximum number of instances for the EKS ASG | `any` | n/a | yes |
| worker\_asg\_min\_size | Minimum number of instances for the EKS ASG | `any` | n/a | yes |
| worker\_instance\_types | Instance types to use for the EKS workers. When use\_spot\_instances is true you may provide multiple instance types and it will diversify across the cheapest pools | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | Identifier of the EKS cluster |
| worker\_iam\_role\_arn | The ARN of the EKS worker IAM role |
| worker\_iam\_role\_name | The name of the EKS worker IAM role |
| worker\_security\_group\_id | The security group of the EKS workers |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
