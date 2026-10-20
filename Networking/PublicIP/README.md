# Azure Public IP Terraform Module

This module creates an Azure Public IP address with configurable SKU, zones, DNS labels, and diagnostic settings.

## Features

- Standard and Basic SKU support
- Zone-redundant and zonal configurations
- DNS label configuration
- DDoS protection integration
- Public IP Prefix support
- IPv4 and IPv6 support
- Diagnostic settings for monitoring
- Flexible naming convention

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | The Public IP must be created within an existing Resource Group |
| Public IP Prefix | No | Only if allocating from a prefix |
| DDoS Protection Plan | No | Only if `ddos_protection_mode` is "Enabled" |
| Log Analytics Workspace | No | Only for diagnostic settings |

## Usage

### Basic Example

```hcl
module "pip" {
  source = "../../Networking/PublicIP"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name = "pip-gateway-dev-001"
}
```

### Zone-Redundant Standard IP

```hcl
module "pip" {
  source = "../../Networking/PublicIP"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  name              = "pip-lb-prod-001"
  sku               = "Standard"
  allocation_method = "Static"
  zones             = ["1", "2", "3"]
}
```

### With DNS Label

```hcl
module "pip" {
  source = "../../Networking/PublicIP"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name              = "pip-web-dev-001"
  domain_name_label = "myapp-dev"  # Creates: myapp-dev.westeurope.cloudapp.azure.com
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| allocation_method | Static or Dynamic | `string` | `"Static"` | no |
| sku | Basic or Standard | `string` | `"Standard"` | no |
| sku_tier | Regional or Global | `string` | `"Regional"` | no |
| ip_version | IPv4 or IPv6 | `string` | `"IPv4"` | no |
| zones | Availability zones | `list(string)` | `["1","2","3"]` | no |
| idle_timeout_in_minutes | Idle timeout (4-30) | `number` | `4` | no |
| domain_name_label | DNS label | `string` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Public IP |
| name | The name of the Public IP |
| ip_address | The allocated IP address |
| fqdn | The FQDN (if DNS label set) |
| sku | The SKU |
| zones | The availability zones |

## Security Recommendations

1. **Use Standard SKU**: Provides zone redundancy and is required for many services
2. **Restrict Access**: Use NSGs to control traffic to resources with public IPs
3. **Enable DDoS Protection**: Consider DDoS Standard for production workloads
4. **Audit Usage**: Regularly review unused public IPs

## Notes

- Standard SKU requires Static allocation
- Basic SKU does not support zones
- DNS labels must be unique within the region

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
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | (Optional) The allocation method for the Public IP.<br/>Possible values: "Static" or "Dynamic".<br/>Note: Standard SKU requires Static allocation. | `string` | `"Static"` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Public IP. Set to false to disable resource creation. | `bool` | `true` | no |
| <a name="input_ddos_protection_mode"></a> [ddos\_protection\_mode](#input\_ddos\_protection\_mode) | (Optional) The DDoS protection mode.<br/>Possible values: "Disabled", "Enabled", "VirtualNetworkInherited". | `string` | `"VirtualNetworkInherited"` | no |
| <a name="input_ddos_protection_plan_id"></a> [ddos\_protection\_plan\_id](#input\_ddos\_protection\_plan\_id) | (Optional) The ID of the DDoS Protection Plan.<br/>DEPENDENCY: DDoS Protection Plan must exist before referencing.<br/>Required when ddos\_protection\_mode is "Enabled". | `string` | `null` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration for the Public IP.<br/>DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist. | <pre>object({<br/>    name                           = optional(string, "diag-pip")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    log_categories                 = optional(list(string), ["DDoSProtectionNotifications", "DDoSMitigationFlowLogs", "DDoSMitigationReports"])<br/>    metric_categories              = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_domain_name_label"></a> [domain\_name\_label](#input\_domain\_name\_label) | (Optional) The DNS label for the public IP.<br/>Creates FQDN: <label>.<region>.cloudapp.azure.com | `string` | `null` | no |
| <a name="input_domain_name_label_scope"></a> [domain\_name\_label\_scope](#input\_domain\_name\_label\_scope) | (Optional) The scope of the domain name label.<br/>Possible values: "NoReuse", "ResourceGroupReuse", "SubscriptionReuse", "TenantReuse". | `string` | `null` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | (Optional) The Edge Zone where this Public IP should exist. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_idle_timeout_in_minutes"></a> [idle\_timeout\_in\_minutes](#input\_idle\_timeout\_in\_minutes) | (Optional) The idle timeout in minutes (4-30). Default is 4. | `number` | `4` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_ip_tags"></a> [ip\_tags](#input\_ip\_tags) | (Optional) A map of IP tags to assign (e.g., routing preference). | `map(string)` | `{}` | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | (Optional) The IP version. Possible values: 'IPv4' or 'IPv6'. | `string` | `"IPv4"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the Public IP will be deployed.<br/>DEPENDENCY: Should match the Resource Group location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Public IP. If provided, overrides name\_prefix/name\_suffix logic. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix to prepend to the generated Public IP name. | `string` | `"pip"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix to append to the generated Public IP name. | `string` | `""` | no |
| <a name="input_public_ip_prefix_id"></a> [public\_ip\_prefix\_id](#input\_public\_ip\_prefix\_id) | (Optional) The ID of the Public IP Prefix to allocate from.<br/>DEPENDENCY: Public IP Prefix must exist before referencing. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Public IP will be created.<br/>DEPENDENCY: Resource Group must exist before creating the Public IP. | `string` | n/a | yes |
| <a name="input_reverse_fqdn"></a> [reverse\_fqdn](#input\_reverse\_fqdn) | (Optional) The reverse FQDN for the Public IP. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) The SKU of the Public IP.<br/>Possible values: "Basic" or "Standard".<br/>Standard is recommended for production and is required for zone redundancy. | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The SKU tier of the Public IP.<br/>Possible values: "Regional" or "Global".<br/>Global is used for cross-region load balancers. | `string` | `"Regional"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the Public IP. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or purpose name, used for naming convention. | `string` | `"default"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) List of availability zones for the Public IP.<br/>Use ["1", "2", "3"] for zone-redundant or ["1"] for zonal.<br/>Requires Standard SKU. | `list(string)` | <pre>[<br/>  "1",<br/>  "2",<br/>  "3"<br/>]</pre> | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_diagnostic_settings_id"></a> [diagnostic\_settings\_id](#output\_diagnostic\_settings\_id) | The ID of the diagnostic settings (if created). |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name (if domain\_name\_label was set). |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Public IP. |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The IP address value that was allocated. |
| <a name="output_location"></a> [location](#output\_location) | The Azure region where the Public IP is deployed. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Public IP. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group containing the Public IP. |
| <a name="output_sku"></a> [sku](#output\_sku) | The SKU of the Public IP. |
| <a name="output_zones"></a> [zones](#output\_zones) | The availability zones configured for the Public IP. |
<!-- END_TF_DOCS -->