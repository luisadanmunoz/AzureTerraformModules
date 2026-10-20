# Azure API Management

Terraform module for creating Azure API Management Service resources.

## Features

- Full API gateway and management platform
- Multiple SKU tiers (Consumption, Developer, Basic, Standard, Premium)
- VNet integration (External and Internal modes)
- Managed identity support
- TLS/SSL configuration and cipher control
- HTTP/2 protocol support
- Conditional resource creation

## Usage

```hcl
module "apim" {
  source = "path/to/Web/APIManagement"

  name                = "apim-prod-001"
  resource_group_name = azurerm_resource_group.api.name
  location            = "eastus"
  publisher_name      = "Contoso"
  publisher_email     = "api-admin@contoso.com"
  sku_name            = "Standard_1"

  identity_type = "SystemAssigned"

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
| name | Service name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| publisher_name | Publisher name | `string` | n/a | yes |
| publisher_email | Publisher email | `string` | n/a | yes |
| sku_name | SKU name | `string` | `"Developer_1"` | no |
| virtual_network_type | VNet type | `string` | `"None"` | no |
| identity_type | Managed identity type | `string` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The service ID |
| name | The service name |
| gateway_url | The gateway URL |
| portal_url | The publisher portal URL |
| developer_portal_url | The developer portal URL |
| principal_id | System identity principal ID |
