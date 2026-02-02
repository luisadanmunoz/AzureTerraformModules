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
