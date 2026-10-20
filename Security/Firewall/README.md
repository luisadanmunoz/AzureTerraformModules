# Firewall

Terraform module for Azure Firewall.

## Features

- Standard, Premium, and Basic SKU tiers
- Threat intelligence-based filtering (Alert, Deny, Off)
- DNS proxy for DNS resolution
- Availability zones for high availability
- Virtual WAN (vWAN) hub integration
- Forced tunneling with management IP configuration
- Firewall Policy association
- Multiple IP configurations

## Usage

### Basic Firewall with Standard Tier

```hcl
module "firewall" {
  source = "./Security/Firewall"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "myapp"
  environment = "prod"

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  ip_configuration = [
    {
      name                 = "fw-ipconfig"
      subnet_id            = azurerm_subnet.firewall.id
      public_ip_address_id = azurerm_public_ip.firewall.id
    }
  ]
}
```

### Premium Firewall with Policy

```hcl
module "firewall" {
  source = "./Security/Firewall"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "secure"
  environment = "prod"

  sku_name           = "AZFW_VNet"
  sku_tier           = "Premium"
  firewall_policy_id = azurerm_firewall_policy.premium.id
  dns_proxy_enabled  = true
  threat_intel_mode  = "Deny"
  zones              = ["1", "2", "3"]

  ip_configuration = [
    {
      name                 = "fw-ipconfig"
      subnet_id            = azurerm_subnet.firewall.id
      public_ip_address_id = azurerm_public_ip.firewall.id
    }
  ]

  tags = {
    Environment = "Production"
    Compliance  = "Required"
  }
}
```

### Hub Firewall (vWAN)

```hcl
module "firewall" {
  source = "./Security/Firewall"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "hub"
  environment = "prod"

  sku_name          = "AZFW_Hub"
  sku_tier          = "Standard"
  threat_intel_mode = "Alert"

  virtual_hub = {
    virtual_hub_id  = azurerm_virtual_hub.main.id
    public_ip_count = 1
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | Firewall name | `string` | `null` | no |
| name_prefix | Name prefix | `string` | `"fw"` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| create | Create resources | `bool` | `true` | no |
| sku_name | SKU name (AZFW_VNet/AZFW_Hub) | `string` | `"AZFW_VNet"` | no |
| sku_tier | SKU tier (Basic/Standard/Premium) | `string` | `"Standard"` | no |
| firewall_policy_id | Firewall Policy ID | `string` | `null` | no |
| dns_proxy_enabled | Enable DNS proxy | `bool` | `null` | no |
| threat_intel_mode | Threat intelligence mode | `string` | `"Alert"` | no |
| zones | Availability zones | `list(string)` | `[]` | no |
| ip_configuration | IP configuration blocks | `list(object)` | `[]` | no |
| management_ip_configuration | Management IP for forced tunneling | `object` | `null` | no |
| virtual_hub | Virtual Hub config for vWAN | `object` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Azure Firewall ID |
| name | Azure Firewall name |
| ip_configuration | IP configuration list |
| private_ip_address | Private IP address |
| virtual_hub | Virtual hub configuration with private and public IPs |
| resource_group_name | Resource group name |
| location | Azure region |

## Best Practices

1. **Use Firewall Policy** - Manage rules through Azure Firewall Policy for better organization and reuse
2. **Enable availability zones** - Deploy across zones 1, 2, and 3 for high availability
3. **Use Premium for TLS inspection** - Required for IDPS and TLS inspection capabilities
4. **Threat intelligence to Deny** - Set threat_intel_mode to Deny in production environments
5. **DNS proxy for FQDN rules** - Enable dns_proxy_enabled when using FQDN-based network rules
6. **Forced tunneling** - Use management_ip_configuration when routing all traffic through a next hop
