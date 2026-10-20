# Azure Monitor Action Group

Terraform module for creating Azure Monitor Action Group resources.

## Features

- Email, SMS, and push notification receivers
- Webhook integration
- Logic App and Azure Function receivers
- Common alert schema support
- Conditional resource creation

## Usage

```hcl
module "action_group" {
  source = "path/to/MonitoringAndDashboards/ActionGroup"

  name                = "ag-critical-alerts"
  resource_group_name = azurerm_resource_group.monitoring.name
  short_name          = "critical"

  email_receivers = [
    {
      name          = "oncall-team"
      email_address = "oncall@contoso.com"
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Action group name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| short_name | Short name (max 12 chars) | `string` | n/a | yes |
| enabled | Whether enabled | `bool` | `true` | no |
| email_receivers | Email receivers | `list(object)` | `[]` | no |
| sms_receivers | SMS receivers | `list(object)` | `[]` | no |
| webhook_receivers | Webhook receivers | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The action group ID |
| name | The action group name |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_monitor_action_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_azure_app_push_receivers"></a> [azure\_app\_push\_receivers](#input\_azure\_app\_push\_receivers) | List of Azure app push notification receivers. | <pre>list(object({<br/>    name          = string<br/>    email_address = string<br/>  }))</pre> | `[]` | no |
| <a name="input_azure_function_receivers"></a> [azure\_function\_receivers](#input\_azure\_function\_receivers) | List of Azure Function receivers. | <pre>list(object({<br/>    name                     = string<br/>    function_app_resource_id = string<br/>    function_name            = string<br/>    http_trigger_url         = string<br/>    use_common_alert_schema  = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Action Group. | `bool` | `true` | no |
| <a name="input_email_receivers"></a> [email\_receivers](#input\_email\_receivers) | List of email receivers. | <pre>list(object({<br/>    name                    = string<br/>    email_address           = string<br/>    use_common_alert_schema = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the Action Group is enabled. | `bool` | `true` | no |
| <a name="input_logic_app_receivers"></a> [logic\_app\_receivers](#input\_logic\_app\_receivers) | List of Logic App receivers. | <pre>list(object({<br/>    name                    = string<br/>    resource_id             = string<br/>    callback_url            = string<br/>    use_common_alert_schema = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Action Group. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_short_name"></a> [short\_name](#input\_short\_name) | The short name of the Action Group (max 12 characters). | `string` | n/a | yes |
| <a name="input_sms_receivers"></a> [sms\_receivers](#input\_sms\_receivers) | List of SMS receivers. | <pre>list(object({<br/>    name         = string<br/>    country_code = string<br/>    phone_number = string<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_webhook_receivers"></a> [webhook\_receivers](#input\_webhook\_receivers) | List of webhook receivers. | <pre>list(object({<br/>    name                    = string<br/>    service_uri             = string<br/>    use_common_alert_schema = optional(bool, true)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Action Group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Action Group. |
<!-- END_TF_DOCS -->