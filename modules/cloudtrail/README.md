# cloudtrail

Enable CloudTrail logging for management and service events

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
| environment | The environment (development/staging/production) | `any` | n/a | yes |
| include\_global\_service\_events | Specifies whether the trail is publishing events from global services such as IAM to the log files | `any` | n/a | yes |
| project | Name of the project | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloudtrail\_arn | The Amazon Resource Name of the trail |
| cloudtrail\_bucket\_id | The bucket ID of the trail |
| cloudtrail\_id | The name of the trail |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
