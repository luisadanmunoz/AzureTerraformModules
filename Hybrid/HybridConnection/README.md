# Azure Relay Hybrid Connection

Terraform module for creating Azure Relay Hybrid Connections.

## Features

- Connect cloud apps to on-premises resources without VPN
- Secure WebSocket-based tunnels
- Client authorization support
- Works with App Service, Functions, Logic Apps

## Usage

```hcl
module "hybrid_conn" {
  source = "path/to/Hybrid/HybridConnection"

  name                 = "hc-database"
  resource_group_name  = azurerm_resource_group.hybrid.name
  relay_namespace_name = module.relay_namespace.name

  user_metadata                 = "db-server.internal:1433"
  requires_client_authorization = true
}
```

## Use Cases

- Connect App Service to on-premises SQL Server
- Access internal APIs from Azure Functions
- Hybrid data integration without VPN

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Hybrid Connection | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| relay_namespace_name | Relay Namespace name | `string` | n/a | yes |
| create | Whether to create | `bool` | `true` | no |
| requires_client_authorization | Require auth | `bool` | `true` | no |
| user_metadata | Endpoint (hostname:port) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The resource ID |
| name | The resource name |
