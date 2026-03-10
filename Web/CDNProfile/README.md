# Azure CDN Profile

Terraform module for creating Azure CDN Profile resources.

## Features

- Content delivery network for static content acceleration
- Multiple SKU options (Microsoft, Verizon, Akamai)
- Global content distribution
- Conditional resource creation

## Usage

```hcl
module "cdn_profile" {
  source = "path/to/Web/CDNProfile"

  name                = "cdn-static-prod"
  resource_group_name = azurerm_resource_group.web.name
  location            = "eastus"
  sku                 = "Standard_Microsoft"

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
| name | Profile name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| sku | SKU type | `string` | `"Standard_Microsoft"` | no |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The profile ID |
| name | The profile name |
