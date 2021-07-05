# eks

Create a Kubernetes cluster using EKS.

## Notes

This module supports using EKS "Addons" to maintain and upgrade core resources in the cluster like the VPC CNI, kube-proxy and Core DNS.

See the necessary versions for each EKS version here:
[https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html]()
[https://docs.aws.amazon.com/eks/latest/userguide/managing-coredns.html]()
[https://docs.aws.amazon.com/eks/latest/userguide/managing-kube-proxy.html]()

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.37.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.37.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| addon\_coredns\_version | Version of CoreDNS to install. If empty you will need to upgrade CoreDNS yourself during a cluster version upgrade | `string` | `""` | no |
| addon\_kube\_proxy\_version | Version of kube proxy to install. If empty you will need to upgrade kube proxy yourself during a cluster version upgrade | `string` | `""` | no |
| addon\_vpc\_cni\_version | Version of the VPC CNI to install. If empty you will need to upgrade the CNI yourself during a cluster version upgrade | `string` | `""` | no |
| cluster\_name | Name to be given to the EKS cluster | `any` | n/a | yes |
| cluster\_version | EKS cluster version number to use. Incrementing this will start a cluster upgrade | `any` | n/a | yes |
| eks\_node\_groups | Map of maps of EKS node group config where keys are node group names | <pre>map(object({<br>    instance_types     = list(string)<br>    asg_min_size       = string<br>    asg_max_size       = string<br>    use_spot_instances = bool<br>    ami_type           = string<br>  }))</pre> | n/a | yes |
| environment | The environment (stage/prod) | `any` | n/a | yes |
| iam\_account\_id | Account ID of the current IAM user | `any` | n/a | yes |
| iam\_role\_mapping | List of mappings of AWS Roles to Kubernetes Groups | <pre>list(object({<br>    iam_role_arn  = string<br>    k8s_role_name = string<br>    k8s_groups    = list(string)<br>  }))</pre> | n/a | yes |
| private\_subnets | VPC subnets for the EKS cluster | `list(string)` | n/a | yes |
| project | Name of the project | `any` | n/a | yes |
| vpc\_id | VPC ID for EKS cluster | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | Identifier of the EKS cluster |
| worker\_iam\_role\_arn | The ARN of the EKS worker IAM role |
| worker\_iam\_role\_name | The name of the EKS worker IAM role |
| worker\_security\_group\_id | The security group of the EKS cluster |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
