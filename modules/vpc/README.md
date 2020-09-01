# vpc

Create a VPC for a specific environment, all other resources will be created inside this VPC where applicable.

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | The environment (development/staging/production) | `any` | n/a | yes |
| kubernetes\_cluster\_name | Kubernetes cluster name used to associate with subnets for auto LB placement | `any` | n/a | yes |
| project | The name of the project, mostly for tagging | `any` | n/a | yes |
| region | The AWS region | `any` | n/a | yes |
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
