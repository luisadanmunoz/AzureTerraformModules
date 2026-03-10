# Firewall Policy

Terraform module for Azure Firewall Policy.

## Features

- Basic, Standard, and Premium SKU tiers
- Threat intelligence-based filtering with allowlists
- DNS settings with proxy and custom servers
- Intrusion detection and prevention (Premium SKU)
- Insights and logging with Log Analytics integration
- Policy inheritance via base policy

## Usage

### Basic Standard Policy

```hcl
module "firewall_policy" {
  source = "./Security/FirewallPolicy"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "hub"
  environment = "prod"

  sku                      = "Standard"
  threat_intelligence_mode = "Alert"

  dns = {
    proxy_enabled = true
    servers       = ["10.0.1.4", "10.0.1.5"]
  }
}
```

### Premium with Intrusion Detection

```hcl
module "firewall_policy_premium" {
  source = "./Security/FirewallPolicy"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "secure"
  environment = "prod"

  sku                      = "Premium"
  threat_intelligence_mode = "Deny"

  dns = {
    proxy_enabled = true
    servers       = ["10.0.1.4"]
  }

  intrusion_detection = {
    mode = "Alert"
    signature_overrides = [
      {
        id    = "2024897"
        state = "Off"
      }
    ]
    traffic_bypass = [
      {
        name                  = "AllowInternalTraffic"
        protocol              = "Any"
        description           = "Bypass IDS for internal traffic"
        source_addresses      = ["10.0.0.0/8"]
        destination_addresses = ["10.0.0.0/8"]
        destination_ports     = ["*"]
      }
    ]
  }

  threat_intelligence_allowlist = {
    fqdns        = ["internal.example.com"]
    ip_addresses = ["10.0.0.0/8"]
  }

  insights = {
    enabled                            = true
    default_log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
    retention_in_days                  = 90
  }

  tags = {
    Environment = "Production"
    SecurityTier = "Premium"
  }
}
```

### Child Policy with Inheritance

```hcl
module "firewall_policy_child" {
  source = "./Security/FirewallPolicy"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "spoke"
  environment = "prod"

  sku             = "Standard"
  base_policy_id  = module.firewall_policy.id
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
| name | Firewall Policy name | `string` | `null` | no |
| name_prefix | Name prefix | `string` | `"fwp"` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| create | Create resources | `bool` | `true` | no |
| sku | SKU tier (Basic/Standard/Premium) | `string` | `"Standard"` | no |
| base_policy_id | Base policy ID for inheritance | `string` | `null` | no |
| threat_intelligence_mode | Threat intelligence mode (Alert/Deny/Off) | `string` | `"Alert"` | no |
| threat_intelligence_allowlist | Threat intelligence allowlist | `object` | `null` | no |
| dns | DNS configuration | `object` | `null` | no |
| intrusion_detection | Intrusion detection config (Premium) | `object` | `null` | no |
| insights | Insights and logging config | `object` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Firewall Policy ID |
| name | Firewall Policy name |
| child_policies | Child Firewall Policies |
| firewalls | Associated Azure Firewalls |
| rule_collection_groups | Rule Collection Groups |
| resource_group_name | Resource group name |
| location | Location |

## Best Practices

1. **Use Premium for IDPS** - Intrusion detection and prevention requires Premium SKU
2. **Enable DNS proxy** - Required for FQDN-based rules in network rule collections
3. **Use threat intelligence** - Set to Deny mode for production to block known malicious traffic
4. **Policy inheritance** - Use base policies for shared rules across hub-spoke topologies
5. **Enable insights** - Connect to Log Analytics for monitoring and compliance
6. **Secure DNS servers** - Use private DNS resolvers or Azure DNS for custom DNS servers
