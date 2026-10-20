# Azure Event Grid Topic Terraform Module

This Terraform module creates an Azure Event Grid Topic with support for custom schemas, input mapping, identity configuration, and network access controls.

## Features

- Configurable naming convention with prefix, workload, environment, and instance
- Support for multiple input schemas (EventGridSchema, CustomEventSchema, CloudEventSchemaV1_0)
- Custom event schema support with input mapping fields and default values
- Managed Identity support (System-assigned, User-assigned, or both)
- Inbound IP rules for network access control
- Public network access configuration
- Local authentication control
- Conditional resource creation with `create` variable

## Usage

### Basic Example

```hcl
module "eventgrid_topic" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name_prefix = "evgt"
  workload    = "myapp"
  environment = "dev"
  instance    = "001"

  tags = {
    Project = "Example"
  }
}
```

### With Custom Event Schema

```hcl
module "eventgrid_topic_custom" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "evgt-custom-schema"

  input_schema = "CustomEventSchema"

  input_mapping_fields = {
    id           = "customId"
    topic        = "customTopic"
    event_time   = "customEventTime"
    event_type   = "customEventType"
    subject      = "customSubject"
    data_version = "customDataVersion"
  }

  input_mapping_default_values = {
    event_type   = "DefaultEventType"
    subject      = "DefaultSubject"
    data_version = "1.0"
  }

  tags = {
    Project = "CustomSchema"
  }
}
```

### With Managed Identity

```hcl
module "eventgrid_topic_identity" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "evgt-with-identity"

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Project = "Identity"
  }
}
```

### With IP Restrictions

```hcl
module "eventgrid_topic_restricted" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "evgt-restricted"

  public_network_access_enabled = true
  local_auth_enabled            = false

  inbound_ip_rule = [
    {
      ip_mask = "10.0.0.0/8"
      action  = "Allow"
    },
    {
      ip_mask = "192.168.1.0/24"
      action  = "Allow"
    }
  ]

  tags = {
    Project = "Restricted"
  }
}
```

### With CloudEvents Schema

```hcl
module "eventgrid_topic_cloudevents" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "evgt-cloudevents"

  input_schema = "CloudEventSchemaV1_0"

  tags = {
    Project = "CloudEvents"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_eventgrid_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether the Event Grid Topic should be created. | `bool` | `true` | no |
| resource_group_name | The name of the resource group in which to create the Event Grid Topic. | `string` | n/a | yes |
| location | The Azure region where the Event Grid Topic should be created. | `string` | n/a | yes |
| name | The name of the Event Grid Topic. If provided, overrides the generated name. | `string` | `null` | no |
| name_prefix | The prefix for the generated Event Grid Topic name. | `string` | `"evgt"` | no |
| workload | The workload name to use for the generated name. | `string` | `null` | no |
| environment | The environment name to use for the generated name. | `string` | `null` | no |
| instance | The instance identifier to use for the generated name. | `string` | `null` | no |
| tags | A mapping of tags to assign to the Event Grid Topic. | `map(string)` | `{}` | no |
| input_schema | The schema in which incoming events will be published. Allowed values are EventGridSchema, CustomEventSchema, or CloudEventSchemaV1_0. | `string` | `"EventGridSchema"` | no |
| public_network_access_enabled | Whether or not public network access is allowed for this Event Grid Topic. | `bool` | `true` | no |
| local_auth_enabled | Whether or not local authentication is enabled for this Event Grid Topic. | `bool` | `true` | no |
| input_mapping_fields | A mapping of input field names to their corresponding schema fields. Only applicable when input_schema is CustomEventSchema. | `object` | `null` | no |
| input_mapping_default_values | Default values used when the input event does not include certain fields. Only applicable when input_schema is CustomEventSchema. | `object` | `null` | no |
| inbound_ip_rule | A list of inbound IP rules for the Event Grid Topic. | `list(object)` | `[]` | no |
| identity | An identity block for the Event Grid Topic. | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Event Grid Topic. |
| name | The name of the Event Grid Topic. |
| endpoint | The endpoint URI of the Event Grid Topic. |
| primary_access_key | The primary access key of the Event Grid Topic. |
| secondary_access_key | The secondary access key of the Event Grid Topic. |
| principal_id | The Principal ID associated with the Managed Service Identity of the Event Grid Topic. |

## Dependencies

This module has the following dependencies:

- `azurerm_resource_group` - The resource group must exist before creating the Event Grid Topic.

## Notes

- The `input_mapping_fields` and `input_mapping_default_values` variables are only applicable when `input_schema` is set to `CustomEventSchema`.
- When using `inbound_ip_rule`, the IP addresses must be specified in CIDR notation.
- The `primary_access_key` and `secondary_access_key` outputs are marked as sensitive.
- When `local_auth_enabled` is set to `false`, the access keys will not be usable, and clients must authenticate using Azure AD.

## License

This module is licensed under the MIT License.

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
| [azurerm_eventgrid_topic.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether the Event Grid Topic should be created. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name to use for the generated name. | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | An identity block for the Event Grid Topic. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_inbound_ip_rule"></a> [inbound\_ip\_rule](#input\_inbound\_ip\_rule) | A list of inbound IP rules for the Event Grid Topic. | <pre>list(object({<br/>    ip_mask = string<br/>    action  = optional(string, "Allow")<br/>  }))</pre> | `[]` | no |
| <a name="input_input_mapping_default_values"></a> [input\_mapping\_default\_values](#input\_input\_mapping\_default\_values) | Default values used when the input event does not include certain fields. Only applicable when input\_schema is CustomEventSchema. | <pre>object({<br/>    event_type   = optional(string)<br/>    subject      = optional(string)<br/>    data_version = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_input_mapping_fields"></a> [input\_mapping\_fields](#input\_input\_mapping\_fields) | A mapping of input field names to their corresponding schema fields. Only applicable when input\_schema is CustomEventSchema. | <pre>object({<br/>    id           = optional(string)<br/>    topic        = optional(string)<br/>    event_time   = optional(string)<br/>    event_type   = optional(string)<br/>    subject      = optional(string)<br/>    data_version = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_input_schema"></a> [input\_schema](#input\_input\_schema) | The schema in which incoming events will be published. Allowed values are EventGridSchema, CustomEventSchema, or CloudEventSchemaV1\_0. | `string` | `"EventGridSchema"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier to use for the generated name. | `string` | `null` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | Whether or not local authentication is enabled for this Event Grid Topic. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Event Grid Topic should be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Event Grid Topic. If provided, overrides the generated name. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix for the generated Event Grid Topic name. | `string` | `"evgt"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this Event Grid Topic. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Event Grid Topic. # DEPENDENCY: azurerm\_resource\_group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the Event Grid Topic. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name to use for the generated name. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint URI of the Event Grid Topic. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Event Grid Topic. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Event Grid Topic. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key of the Event Grid Topic. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID associated with the Managed Service Identity of the Event Grid Topic. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key of the Event Grid Topic. |
<!-- END_TF_DOCS -->