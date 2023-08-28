# user_access

Create IAM Roles/Groups and Kubernetes Cluster Roles for user access

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.access_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.access_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.access_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user_group_membership.access_user_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.access_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (stage/prod) | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of the project | `any` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | Roles to create with associated aws policies | <pre>list(object({<br>    name       = string<br>    aws_policy = string<br>  }))</pre> | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | Users to create with associated roles, mapping to the ones defined in the roles variable | <pre>list(object({<br>    name  = string<br>    roles = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
