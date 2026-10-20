# Azure Relay Namespace

Terraform module for creating Azure Relay Namespaces for hybrid connectivity without VPN.

## Features

- Hybrid connectivity without VPN/firewall changes
- Secure WebSocket-based communication
- Support for Hybrid Connections and WCF Relays
- Built-in authentication with SAS keys

## Usage

```hcl
module "relay_ns" {
  source = "path/to/Hybrid/RelayNamespace"

  name                = "relay-prod-001"
  resource_group_name = azurerm_resource_group.hybrid.name
  location            = "westeurope"

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
| name | Name of the Relay Namespace | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| create | Whether to create | `bool` | `true` | no |
| sku_name | SKU (Standard only) | `string` | `"Standard"` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The resource ID |
| name | The resource name |
| primary_connection_string | Primary connection string (sensitive) |
| secondary_connection_string | Secondary connection string (sensitive) |
| primary_key | Primary SAS key (sensitive) |
| secondary_key | Secondary SAS key (sensitive) |

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
| [azurerm_relay_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/relay_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Relay Namespace. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region for the Relay Namespace. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Relay Namespace. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of the Relay Namespace. Only Standard is supported. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Relay Namespace. |
| <a name="output_metric_id"></a> [metric\_id](#output\_metric\_id) | The metric ID for monitoring. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Relay Namespace. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string. |
| <a name="output_primary_key"></a> [primary\_key](#output\_primary\_key) | The primary access key. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The secondary connection string. |
| <a name="output_secondary_key"></a> [secondary\_key](#output\_secondary\_key) | The secondary access key. |
<!-- END_TF_DOCS -->