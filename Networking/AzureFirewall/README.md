# Azure Firewall Terraform Module

This module creates an Azure Firewall with support for VNet and Virtual Hub deployments, multiple SKU tiers, and comprehensive configuration options.

## Features

- VNet deployment (AZFW_VNet) and Virtual Hub deployment (AZFW_Hub)
- SKU tiers: Basic, Standard, Premium
- Automatic Public IP creation or use existing IPs
- Zone redundancy support
- Firewall Policy association
- DNS Proxy configuration
- Threat Intelligence modes
- Forced tunneling support (management IP)
- Diagnostic settings

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| VNet with AzureFirewallSubnet | **Yes*** | Required for AZFW_VNet. Subnet must be exactly named "AzureFirewallSubnet" with /26 minimum |
| Virtual Hub | **Yes*** | Required for AZFW_Hub deployment |
| Firewall Policy | No | Recommended for rule management |
| Public IP(s) | No | Created automatically if not provided |
| AzureFirewallManagementSubnet | No | Only for forced tunneling scenarios |

*One of VNet or Virtual Hub is required depending on sku_name

## Usage

### Standard Firewall in VNet

```hcl
module "firewall" {
  source = "../../Networking/AzureFirewall"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"

  name     = "afw-hub-prod-001"
  sku_tier = "Standard"

  subnet_id          = module.subnet_firewall.id  # AzureFirewallSubnet
  firewall_policy_id = module.firewall_policy.id

  threat_intel_mode = "Deny"
  dns_proxy_enabled = true

  zones = ["1", "2", "3"]

  diagnostic_settings = {
    log_analytics_workspace_id = module.log_analytics.id
  }
}
```

### Premium Firewall with Multiple IPs

```hcl
module "firewall" {
  source = "../../Networking/AzureFirewall"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"

  name     = "afw-hub-prod-001"
  sku_tier = "Premium"  # Enables TLS inspection, IDPS

  subnet_id       = module.subnet_firewall.id
  public_ip_count = 3  # Multiple IPs for SNAT ports

  firewall_policy_id = module.firewall_policy_premium.id

  dns_servers       = ["10.0.0.4", "10.0.0.5"]
  dns_proxy_enabled = true
}
```

### With Existing Public IPs

```hcl
module "firewall" {
  source = "../../Networking/AzureFirewall"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  name                = "afw-hub-prod-001"

  subnet_id     = module.subnet_firewall.id
  public_ip_ids = [module.pip1.id, module.pip2.id]
}
```

### Forced Tunneling Configuration

```hcl
module "firewall" {
  source = "../../Networking/AzureFirewall"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  name                = "afw-hub-prod-001"

  subnet_id          = module.subnet_firewall.id
  firewall_policy_id = module.firewall_policy.id

  # Management IP for forced tunneling
  management_ip_configuration = {
    subnet_id            = module.subnet_firewall_mgmt.id  # AzureFirewallManagementSubnet
    public_ip_address_id = module.pip_mgmt.id
  }
}
```

### Virtual Hub Deployment

```hcl
module "firewall" {
  source = "../../Networking/AzureFirewall"

  resource_group_name = "rg-vwan-prod-001"
  location            = "westeurope"

  name     = "afw-vwan-prod-001"
  sku_name = "AZFW_Hub"
  sku_tier = "Standard"

  virtual_hub = {
    virtual_hub_id  = azurerm_virtual_hub.this.id
    public_ip_count = 1
  }

  firewall_policy_id = module.firewall_policy.id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Firewall name | `string` | auto | no |
| sku_name | AZFW_VNet or AZFW_Hub | `string` | `"AZFW_VNet"` | no |
| sku_tier | Basic, Standard, Premium | `string` | `"Standard"` | no |
| firewall_policy_id | Policy ID | `string` | `null` | no |
| subnet_id | AzureFirewallSubnet ID | `string` | `null` | cond |
| public_ip_count | Number of PIPs to create | `number` | `1` | no |
| public_ip_ids | Existing PIP IDs | `list(string)` | `[]` | no |
| dns_servers | Custom DNS servers | `list(string)` | `null` | no |
| dns_proxy_enabled | Enable DNS Proxy | `bool` | `true` | no |
| threat_intel_mode | Off, Alert, Deny | `string` | `"Alert"` | no |
| zones | Availability zones | `list(string)` | `["1","2","3"]` | no |
| virtual_hub | Virtual Hub config | `object({...})` | `null` | cond |
| management_ip_configuration | Forced tunneling config | `object({...})` | `null` | no |
| diagnostic_settings | Diagnostics config | `object({...})` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Firewall ID |
| name | Firewall name |
| private_ip_address | Private IP (VNet deployment) |
| public_ip_addresses | Associated public IPs |
| virtual_hub_private_ip_address | Private IP (Hub deployment) |
| created_public_ip_ids | Created PIP IDs |
| created_public_ip_addresses | Created PIP addresses |

## SKU Comparison

| Feature | Basic | Standard | Premium |
|---------|-------|----------|---------|
| L3-L7 Filtering | ✓ | ✓ | ✓ |
| Threat Intelligence | - | ✓ | ✓ |
| DNS Proxy | - | ✓ | ✓ |
| FQDN in Network Rules | - | ✓ | ✓ |
| FQDN Tags | - | ✓ | ✓ |
| TLS Inspection | - | - | ✓ |
| IDPS | - | - | ✓ |
| URL Filtering | - | - | ✓ |
| Web Categories | - | - | ✓ |
| Zone Redundancy | - | ✓ | ✓ |

## Security Recommendations

1. **Use Premium SKU** for production with TLS inspection needs
2. **Enable Threat Intelligence** in Deny mode for production
3. **Use Firewall Policy** instead of classic rules for better management
4. **Enable DNS Proxy** for FQDN-based filtering
5. **Configure diagnostics** to Log Analytics for monitoring and threat detection
6. **Use multiple Public IPs** for high SNAT port scenarios

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
| [azurerm_firewall.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Azure Firewall. | `bool` | `true` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration.<br/>DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist. | <pre>object({<br/>    name                           = optional(string, "diag-afw")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    log_categories = optional(list(string), [<br/>      "AzureFirewallApplicationRule",<br/>      "AzureFirewallNetworkRule",<br/>      "AzureFirewallDnsProxy",<br/>      "AZFWNetworkRule",<br/>      "AZFWApplicationRule",<br/>      "AZFWNatRule",<br/>      "AZFWThreatIntel",<br/>      "AZFWIdpsSignature",<br/>      "AZFWDnsQuery",<br/>      "AZFWFqdnResolveFailure",<br/>      "AZFWFatFlow",<br/>      "AZFWFlowTrace"<br/>    ])<br/>    metric_categories = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_dns_proxy_enabled"></a> [dns\_proxy\_enabled](#input\_dns\_proxy\_enabled) | (Optional) Enable DNS Proxy. Required for FQDN filtering in network rules. | `bool` | `true` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional) List of custom DNS servers. If not set, uses Azure DNS. | `list(string)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_firewall_policy_id"></a> [firewall\_policy\_id](#input\_firewall\_policy\_id) | (Optional) The ID of the Firewall Policy to associate.<br/>DEPENDENCY: Firewall Policy must exist. Recommended over classic rules. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the Azure Firewall will be deployed.<br/>DEPENDENCY: Should match the Resource Group and VNet location. | `string` | n/a | yes |
| <a name="input_management_ip_configuration"></a> [management\_ip\_configuration](#input\_management\_ip\_configuration) | (Optional) Management IP configuration for forced tunneling scenarios.<br/>DEPENDENCY: Management subnet (AzureFirewallManagementSubnet) and Public IP must exist.<br/><br/>Attributes:<br/>  - subnet\_id: The ID of the AzureFirewallManagementSubnet.<br/>  - public\_ip\_address\_id: The ID of the management Public IP. | <pre>object({<br/>    subnet_id            = string<br/>    public_ip_address_id = string<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Azure Firewall. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"afw"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix for generated name. | `string` | `""` | no |
| <a name="input_private_ip_ranges"></a> [private\_ip\_ranges](#input\_private\_ip\_ranges) | (Optional) List of SNAT private IP ranges.<br/>Use "IANAPrivateRanges" to SNAT only when destination is public. | `list(string)` | `null` | no |
| <a name="input_public_ip_count"></a> [public\_ip\_count](#input\_public\_ip\_count) | (Optional) Number of Public IPs to create for the firewall. | `number` | `1` | no |
| <a name="input_public_ip_ids"></a> [public\_ip\_ids](#input\_public\_ip\_ids) | (Optional) List of existing Public IP IDs to use instead of creating new ones.<br/>DEPENDENCY: Public IPs must be Standard SKU, Static allocation, in same region.<br/>If provided, public\_ip\_count is ignored. | `list(string)` | `[]` | no |
| <a name="input_public_ip_name_prefix"></a> [public\_ip\_name\_prefix](#input\_public\_ip\_name\_prefix) | (Optional) Prefix for created Public IP names. | `string` | `"pip-afw"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Azure Firewall will be created.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) The SKU name of the Azure Firewall.<br/>Possible values: "AZFW\_Hub", "AZFW\_VNet".<br/>Use "AZFW\_Hub" for Virtual WAN Hub, "AZFW\_VNet" for VNet deployment. | `string` | `"AZFW_VNet"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The SKU tier of the Azure Firewall.<br/>Possible values: "Basic", "Standard", "Premium".<br/>- Basic: Cost-effective for small workloads (limited features)<br/>- Standard: Full L3-L7 filtering, threat intelligence<br/>- Premium: Adds TLS inspection, IDPS, URL filtering | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required for AZFW\_VNet) The ID of the AzureFirewallSubnet.<br/>DEPENDENCY: Subnet named "AzureFirewallSubnet" must exist with minimum /26 prefix. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_threat_intel_mode"></a> [threat\_intel\_mode](#input\_threat\_intel\_mode) | (Optional) Threat Intelligence mode.<br/>Possible values: "Off", "Alert", "Deny".<br/>- Off: Disabled<br/>- Alert: Log only<br/>- Deny: Block malicious traffic | `string` | `"Alert"` | no |
| <a name="input_virtual_hub"></a> [virtual\_hub](#input\_virtual\_hub) | (Required for AZFW\_Hub) Virtual Hub configuration.<br/>DEPENDENCY: Virtual Hub must exist.<br/><br/>Attributes:<br/>  - virtual\_hub\_id: The ID of the Virtual Hub.<br/>  - public\_ip\_count: Number of public IPs (1-100). | <pre>object({<br/>    virtual_hub_id  = string<br/>    public_ip_count = optional(number, 1)<br/>  })</pre> | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for naming convention. | `string` | `"hub"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) Availability zones for the Azure Firewall.<br/>Example: ["1", "2", "3"] for zone redundancy.<br/>Requires Standard or Premium SKU. | `list(string)` | <pre>[<br/>  "1",<br/>  "2",<br/>  "3"<br/>]</pre> | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_created_public_ip_addresses"></a> [created\_public\_ip\_addresses](#output\_created\_public\_ip\_addresses) | IP addresses of Public IPs created by this module. |
| <a name="output_created_public_ip_ids"></a> [created\_public\_ip\_ids](#output\_created\_public\_ip\_ids) | IDs of Public IPs created by this module. |
| <a name="output_diagnostic_settings_id"></a> [diagnostic\_settings\_id](#output\_diagnostic\_settings\_id) | The ID of the diagnostic settings (if created). |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Firewall. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure Firewall. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address of the Azure Firewall. |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | List of public IP addresses associated with the firewall. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group. |
| <a name="output_virtual_hub_private_ip_address"></a> [virtual\_hub\_private\_ip\_address](#output\_virtual\_hub\_private\_ip\_address) | The private IP address in Virtual Hub (Hub deployment only). |
| <a name="output_virtual_hub_public_ip_addresses"></a> [virtual\_hub\_public\_ip\_addresses](#output\_virtual\_hub\_public\_ip\_addresses) | List of public IP addresses in Virtual Hub (Hub deployment only). |
<!-- END_TF_DOCS -->