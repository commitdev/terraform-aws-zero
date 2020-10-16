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
| environment | The environment (development/staging/production) | `any` | n/a | yes |
| iam\_account\_id | Account ID of the current IAM user | `any` | n/a | yes |
| iam\_role\_mapping | List of mappings of users to roles | <pre>list(object({<br>    name   = string<br>    arn    = string<br>    groups = list(string)<br>  }))</pre> | n/a | yes |
| private\_subnets | VPC subnets for the EKS cluster | `any` | n/a | yes |
| project | Name of the project | `any` | n/a | yes |
| vpc\_id | VPC ID for EKS cluster | `any` | n/a | yes |
| worker\_ami | The (EKS-optimized) AMI for EKS worker instances | `any` | n/a | yes |
| worker\_asg\_max\_size | Maximum number of instances for the EKS ASG | `any` | n/a | yes |
| worker\_asg\_min\_size | Minimum number of instances for the EKS ASG | `any` | n/a | yes |
| worker\_instance\_type | Instance type for the EKS workers | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | Identifier of the EKS cluster |
| worker\_iam\_role\_arn | The ARN of the EKS worker IAM role |
| worker\_iam\_role\_name | The name of the EKS worker IAM role |
| worker\_security\_group\_id | The security group of the EKS workers |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
