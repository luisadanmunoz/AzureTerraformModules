# Azure Bastion Terraform Module

This module creates an Azure Bastion Host for secure RDP/SSH access to VMs without public IPs.

## Features

- Basic, Standard, and Premium SKU support
- Native client support (Standard/Premium)
- File copy and shareable links (Standard/Premium)
- IP-based connections (Standard/Premium)
- Session recording (Premium)
- Kerberos authentication
- Scale units for concurrent connections
- Automatic Public IP creation
- Diagnostic settings

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| AzureBastionSubnet | **Yes** | Subnet named exactly "AzureBastionSubnet" with minimum /26 |
| Public IP | No | Created automatically if not provided |
| Virtual Network | No | Required for session recording (Premium) |

## Usage

### Basic Bastion

```hcl
module "bastion" {
  source = "../../Networking/Bastion"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  subnet_id           = azurerm_subnet.bastion.id

  name = "bas-hub-prod-001"
  sku  = "Basic"
}
```

### Standard Bastion with Features

```hcl
module "bastion" {
  source = "../../Networking/Bastion"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  subnet_id           = azurerm_subnet.bastion.id

  name        = "bas-hub-prod-001"
  sku         = "Standard"
  scale_units = 4

  copy_paste_enabled     = true
  file_copy_enabled      = true
  ip_connect_enabled     = true
  tunneling_enabled      = true
  shareable_link_enabled = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| subnet_id | AzureBastionSubnet ID | `string` | n/a | **yes** |
| name | Bastion name | `string` | auto | no |
| sku | Basic, Standard, Premium | `string` | `"Standard"` | no |
| scale_units | Concurrent connections (2-50) | `number` | `2` | no |
| copy_paste_enabled | Enable copy/paste | `bool` | `true` | no |
| file_copy_enabled | Enable file copy | `bool` | `false` | no |
| ip_connect_enabled | Enable IP-based connection | `bool` | `false` | no |
| tunneling_enabled | Enable native client | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Bastion Host ID |
| name | Bastion Host name |
| dns_name | Bastion DNS name |
| public_ip_address | Public IP address |

## SKU Comparison

| Feature | Basic | Standard | Premium |
|---------|-------|----------|---------|
| RDP/SSH via browser | ✓ | ✓ | ✓ |
| Native client support | - | ✓ | ✓ |
| File copy | - | ✓ | ✓ |
| Shareable links | - | ✓ | ✓ |
| IP-based connection | - | ✓ | ✓ |
| Kerberos auth | - | ✓ | ✓ |
| Session recording | - | - | ✓ |
| Scale units | 2 | 2-50 | 2-50 |

## Notes

- AzureBastionSubnet requires minimum /26 prefix (/27 recommended for Standard/Premium)
- Each scale unit supports 20-25 concurrent RDP connections and 40-50 SSH connections
- VMs don't need public IPs when using Bastion
