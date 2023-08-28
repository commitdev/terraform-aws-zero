# vpc

Create a VPC for a specific environment, all other resources will be created inside this VPC where applicable.

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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.13.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nat_instance"></a> [nat\_instance](#module\_nat\_instance) | int128/nat-instance/aws | 2.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 2.70.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR for the VPC, must be a /16 at least | `string` | `"10.10.0.0/16"` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Create NAT gateway(s) to allow private subnets to route traffic out to the public internet. If this is set to false, it will create a NAT instance instead. This can be useful in non-production environments to reduce cost, though in some cases it may lead to network instability or lower throughput. | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (stage/prod) | `any` | n/a | yes |
| <a name="input_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#input\_kubernetes\_cluster\_name) | Kubernetes cluster name used to associate with subnets for auto LB placement | `any` | n/a | yes |
| <a name="input_nat_instance_types"></a> [nat\_instance\_types](#input\_nat\_instance\_types) | Candidates of instance type for the NAT instance | `list(any)` | <pre>[<br>  "t3.nano",<br>  "t3a.nano"<br>]</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the project, mostly for tagging | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to create resources in | `any` | n/a | yes |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Use single nat-gateway instead of nat-gateway per subnet | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | Availability zones for the VPC |
| <a name="output_database_subnet_group"></a> [database\_subnet\_group](#output\_database\_subnet\_group) | List of subnet groups |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | List of public subnets |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of public subnets |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the created VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
