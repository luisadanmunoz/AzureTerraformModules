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
| [azurerm_relay_hybrid_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/relay_hybrid_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Hybrid Connection. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Hybrid Connection. | `string` | n/a | yes |
| <a name="input_relay_namespace_name"></a> [relay\_namespace\_name](#input\_relay\_namespace\_name) | The name of the Relay Namespace. | `string` | n/a | yes |
| <a name="input_requires_client_authorization"></a> [requires\_client\_authorization](#input\_requires\_client\_authorization) | Whether client authorization is required. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_user_metadata"></a> [user\_metadata](#input\_user\_metadata) | User-defined metadata in the format hostname:port. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Hybrid Connection. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Hybrid Connection. |
<!-- END_TF_DOCS -->