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
