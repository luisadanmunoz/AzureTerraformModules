# Azure Arc Private Link Scope

Terraform module for creating Azure Arc Private Link Scopes for secure private connectivity.

## Features

- Private connectivity for Arc-enabled servers
- Disable public network access
- Integrate with Private Endpoints
- Secure hybrid management traffic

## Usage

```hcl
module "arc_pls" {
  source = "path/to/Hybrid/ArcPrivateLinkScope"

  name                          = "pls-arc-prod"
  resource_group_name           = azurerm_resource_group.arc.name
  location                      = "westeurope"
  public_network_access_enabled = false

  tags = {
    Environment = "Production"
  }
}

# Create Private Endpoint for the Arc Private Link Scope
resource "azurerm_private_endpoint" "arc" {
  name                = "pe-arc"
  location            = azurerm_resource_group.arc.location
  resource_group_name = azurerm_resource_group.arc.name
  subnet_id           = azurerm_subnet.private.id

  private_service_connection {
    name                           = "arc-connection"
    private_connection_resource_id = module.arc_pls.id
    subresource_names              = ["hybridcompute"]
    is_manual_connection           = false
  }
}
```

## Architecture

1. Create Arc Private Link Scope
2. Create Private Endpoint in your VNet
3. Associate Arc-enabled servers with the scope
4. All Arc traffic flows through private connection

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Private Link Scope | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| public_network_access_enabled | Allow public access | `bool` | `false` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The resource ID |
| name | The resource name |
| resource_group_name | The resource group |
| location | The Azure region |

## Best Practices

1. **Disable Public Access**: Set `public_network_access_enabled = false`
2. **Private DNS**: Configure private DNS zones for Arc endpoints
3. **Network Segmentation**: Use dedicated subnets for Arc Private Endpoints
