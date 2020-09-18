# iam_users

Create IAM role and users for EKS

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
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | The environment (development/staging/production) | `any` | n/a | yes |
| iam\_roles | IAM role list with policy | `list(tuple([string, string]))` | n/a | yes |
| iam\_users | IAM user list with multiple roles assigned | `list(tuple([string, list(string)]))` | n/a | yes |
| project | Name of the project | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| eks\_iam\_role\_arns | List of role and users |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
