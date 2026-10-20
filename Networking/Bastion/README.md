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
| [azurerm_bastion_host.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_copy_paste_enabled"></a> [copy\_paste\_enabled](#input\_copy\_paste\_enabled) | (Optional) Enable copy/paste functionality. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Bastion Host. | `bool` | `true` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration. | <pre>object({<br/>    name                       = optional(string, "diag-bastion")<br/>    log_analytics_workspace_id = optional(string, null)<br/>    storage_account_id         = optional(string, null)<br/>    log_categories             = optional(list(string), ["BastionAuditLogs"])<br/>    metric_categories          = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_file_copy_enabled"></a> [file\_copy\_enabled](#input\_file\_copy\_enabled) | (Optional) Enable file copy feature (Standard/Premium SKU only). | `bool` | `false` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_ip_connect_enabled"></a> [ip\_connect\_enabled](#input\_ip\_connect\_enabled) | (Optional) Enable IP-based connection (Standard/Premium SKU only). | `bool` | `false` | no |
| <a name="input_kerberos_enabled"></a> [kerberos\_enabled](#input\_kerberos\_enabled) | (Optional) Enable Kerberos authentication (Standard/Premium SKU only). | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the Bastion Host. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"bas"` | no |
| <a name="input_public_ip_id"></a> [public\_ip\_id](#input\_public\_ip\_id) | (Optional) Existing Public IP ID. If not provided, a new one will be created.<br/>DEPENDENCY: Must be Standard SKU, Static allocation. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_scale_units"></a> [scale\_units](#input\_scale\_units) | (Optional) Number of scale units (2-50). Each unit supports 20 concurrent connections. | `number` | `2` | no |
| <a name="input_session_recording_enabled"></a> [session\_recording\_enabled](#input\_session\_recording\_enabled) | (Optional) Enable session recording (Premium SKU only). | `bool` | `false` | no |
| <a name="input_shareable_link_enabled"></a> [shareable\_link\_enabled](#input\_shareable\_link\_enabled) | (Optional) Enable shareable links (Standard/Premium SKU only). | `bool` | `false` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) Bastion SKU: Basic, Standard, or Premium.<br/>- Basic: RDP/SSH only<br/>- Standard: Adds native client, IP-based connection, shareable link<br/>- Premium: Adds session recording | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the AzureBastionSubnet.<br/>DEPENDENCY: Subnet named "AzureBastionSubnet" must exist with minimum /26 prefix. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_tunneling_enabled"></a> [tunneling\_enabled](#input\_tunneling\_enabled) | (Optional) Enable native client tunneling (Standard/Premium SKU only). | `bool` | `false` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | (Optional) VNet ID for session recording (Premium SKU only).<br/>DEPENDENCY: VNet must exist. | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"hub"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The DNS name of the Bastion Host. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Bastion Host. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Bastion Host. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The public IP address of the Bastion Host. |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | The ID of the Public IP. |
<!-- END_TF_DOCS -->