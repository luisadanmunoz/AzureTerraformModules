<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_storage_management_policy.storage_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_rules"></a> [rules](#input\_rules) | value to set the rules | <pre>list(object({<br/>    name    = string<br/>    enabled = bool<br/>    filters = object({<br/>      blob_types   = list(string)<br/>      prefix_match = optional(list(string))<br/>    })<br/>    actions = object({<br/>      base_blob = optional(object({<br/>        auto_tier_to_hot_from_cool_enabled                             = optional(bool)<br/>        delete_after_days_since_creation_greater_than                  = optional(number)<br/>        delete_after_days_since_last_access_time_greater_than          = optional(number)<br/>        delete_after_days_since_modification_greater_than              = optional(number)<br/>        tier_to_archive_after_days_since_creation_greater_than         = optional(number)<br/>        tier_to_archive_after_days_since_last_access_time_greater_than = optional(number)<br/>        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br/>        tier_to_archive_after_days_since_modification_greater_than     = optional(number)<br/>        tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br/>        tier_to_cold_after_days_since_last_access_time_greater_than    = optional(number)<br/>        tier_to_cold_after_days_since_modification_greater_than        = optional(number)<br/>        tier_to_cool_after_days_since_creation_greater_than            = optional(number)<br/>        tier_to_cool_after_days_since_last_access_time_greater_than    = optional(number)<br/>        tier_to_cool_after_days_since_modification_greater_than        = optional(number)<br/>      }))<br/>      snapshot = optional(object({<br/>        change_tier_to_archive_after_days_since_creation               = optional(number)<br/>        change_tier_to_cool_after_days_since_creation                  = optional(number)<br/>        delete_after_days_since_creation_greater_than                  = optional(number)<br/>        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br/>        tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br/>      }))<br/>      version = optional(object({<br/>        change_tier_to_archive_after_days_since_creation               = optional(number)<br/>        change_tier_to_cool_after_days_since_creation                  = optional(number)<br/>        delete_after_days_since_creation                               = optional(number)<br/>        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)<br/>        tier_to_cold_after_days_since_creation_greater_than            = optional(number)<br/>      }))<br/>    })<br/>  }))</pre> | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | value to set the storage account id | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT STORAGE MANAGEMENT POLICY ############################################################################ |
<!-- END_TF_DOCS -->