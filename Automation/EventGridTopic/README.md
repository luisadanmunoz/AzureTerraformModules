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
