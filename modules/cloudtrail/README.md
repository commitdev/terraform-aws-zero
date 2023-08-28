# cloudtrail

Enable CloudTrail logging for management and service events

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
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| include\_global\_service\_events | Specifies whether the trail is publishing events from global services such as IAM to the log files | `any` | n/a | yes |
| project | Name of the project | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloudtrail\_arn | The Amazon Resource Name of the trail |
| cloudtrail\_bucket\_id | The bucket ID of the trail |
| cloudtrail\_id | The name of the trail |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
