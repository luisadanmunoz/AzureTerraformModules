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
| [azurerm_firewall_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_base_policy_id"></a> [base\_policy\_id](#input\_base\_policy\_id) | The ID of the base Firewall Policy for policy inheritance. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_dns"></a> [dns](#input\_dns) | DNS configuration for the Firewall Policy. | <pre>object({<br/>    proxy_enabled = optional(bool, false)<br/>    servers       = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_insights"></a> [insights](#input\_insights) | Insights and logging configuration for the Firewall Policy. | <pre>object({<br/>    enabled                            = optional(bool, true)<br/>    default_log_analytics_workspace_id = string<br/>    retention_in_days                  = optional(number, 30)<br/>    log_analytics_workspace = optional(list(object({<br/>      id                = string<br/>      firewall_location = string<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_intrusion_detection"></a> [intrusion\_detection](#input\_intrusion\_detection) | Intrusion detection configuration (requires Premium SKU). | <pre>object({<br/>    mode = optional(string, "Off")<br/>    signature_overrides = optional(list(object({<br/>      id    = optional(string)<br/>      state = optional(string)<br/>    })), [])<br/>    traffic_bypass = optional(list(object({<br/>      name                  = string<br/>      protocol              = string<br/>      description           = optional(string)<br/>      destination_addresses = optional(list(string), [])<br/>      destination_ip_groups = optional(list(string), [])<br/>      destination_ports     = optional(list(string), [])<br/>      source_addresses      = optional(list(string), [])<br/>      source_ip_groups      = optional(list(string), [])<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Firewall Policy will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Firewall Policy. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the Firewall Policy name. | `string` | `"fwp"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Firewall Policy will be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU tier for the Firewall Policy. Possible values are Basic, Standard, and Premium. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_threat_intelligence_allowlist"></a> [threat\_intelligence\_allowlist](#input\_threat\_intelligence\_allowlist) | Threat intelligence allowlist configuration. | <pre>object({<br/>    fqdns        = optional(list(string), [])<br/>    ip_addresses = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_threat_intelligence_mode"></a> [threat\_intelligence\_mode](#input\_threat\_intelligence\_mode) | The operation mode for threat intelligence-based filtering. Possible values are Alert, Deny, and Off. | `string` | `"Alert"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_child_policies"></a> [child\_policies](#output\_child\_policies) | A list of references to child Firewall Policies of this Firewall Policy. |
| <a name="output_firewalls"></a> [firewalls](#output\_firewalls) | A list of references to Azure Firewalls that this Firewall Policy is associated with. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Firewall Policy. |
| <a name="output_location"></a> [location](#output\_location) | The location of the Firewall Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Firewall Policy. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group name of the Firewall Policy. |
| <a name="output_rule_collection_groups"></a> [rule\_collection\_groups](#output\_rule\_collection\_groups) | A list of references to Firewall Policy Rule Collection Groups that belong to this Firewall Policy. |
<!-- END_TF_DOCS -->