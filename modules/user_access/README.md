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
| project | Name of the project | `any` | n/a | yes |
| roles | Role list with policy | <pre>list(object({<br>    name   = string<br>    policy = string<br>  }))</pre> | n/a | yes |
| users | User list with multiple roles granted | <pre>list(object({<br>    name  = string<br>    roles = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| eks\_iam\_role\_mapping | List of mappings of users to roles |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
