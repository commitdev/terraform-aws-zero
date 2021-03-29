# vpc

Create a VPC for a specific environment, all other resources will be created inside this VPC where applicable.

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
| enable\_nat\_gateway | Create NAT gateway(s) to allow private subnets to route traffic out to the public internet. If this is set to false, it will create a NAT instance instead. This can be useful in non-production environments to reduce cost, though in some cases it may lead to network instability or lower throughput. | `bool` | n/a | yes |
| environment | The environment (stage/prod) | `any` | n/a | yes |
| kubernetes\_cluster\_name | Kubernetes cluster name used to associate with subnets for auto LB placement | `any` | n/a | yes |
| nat\_instance\_types | Candidates of instance type for the NAT instance | `list(any)` | <pre>[<br>  "t3.nano",<br>  "t3a.nano"<br>]</pre> | no |
| project | The name of the project, mostly for tagging | `any` | n/a | yes |
| region | The AWS region to create resources in | `any` | n/a | yes |
| single\_nat\_gateway | Use single nat-gateway instead of nat-gateway per subnet | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| azs | Availability zones for the VPC |
| database\_subnet\_group | List of subnet groups |
| database\_subnets | List of public subnets |
| private\_subnets | List of private subnets |
| public\_subnets | List of public subnets |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_id | The ID of the created VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
