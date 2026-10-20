# Azure Firewall Policy Terraform Module

This module creates an Azure Firewall Policy with support for all SKU tiers, threat intelligence, IDPS, TLS inspection, and DNS configuration.

## Features

- SKU tiers: Basic, Standard, Premium
- Policy inheritance (base_policy_id)
- Threat Intelligence with allowlists
- DNS proxy configuration
- IDPS with signature overrides (Premium)
- TLS inspection (Premium)
- Explicit proxy (Premium)
- Log Analytics insights

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Parent Policy | No | For policy inheritance |
| Key Vault Certificate | No | For TLS inspection (Premium) |
| User-Assigned Identity | No | For Key Vault access |
| Log Analytics Workspace | No | For insights |

## Usage

### Standard Policy

```hcl
module "firewall_policy" {
  source = "../../Networking/FirewallPolicy"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  name                = "afwp-hub-prod-001"
  sku                 = "Standard"

  threat_intelligence_mode = "Deny"

  dns = {
    proxy_enabled = true
    servers       = ["10.0.0.4"]
  }
}
```

### Premium Policy with IDPS

```hcl
module "firewall_policy" {
  source = "../../Networking/FirewallPolicy"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  name                = "afwp-hub-prod-001"
  sku                 = "Premium"

  intrusion_detection = {
    mode = "Deny"
    signature_overrides = [{
      id    = "2024897"
      state = "Off"
    }]
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Policy name | `string` | auto | no |
| sku | Basic, Standard, Premium | `string` | `"Standard"` | no |
| base_policy_id | Parent policy ID | `string` | `null` | no |
| threat_intelligence_mode | Off, Alert, Deny | `string` | `"Alert"` | no |
| dns | DNS configuration | `object({...})` | `null` | no |
| intrusion_detection | IDPS config (Premium) | `object({...})` | `null` | no |
| tls_certificate | TLS config (Premium) | `object({...})` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Policy ID |
| name | Policy name |
| child_policies | Child policy IDs |
| firewalls | Firewall IDs using this policy |

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
| <a name="input_auto_learn_private_ranges_enabled"></a> [auto\_learn\_private\_ranges\_enabled](#input\_auto\_learn\_private\_ranges\_enabled) | (Optional) Enable auto-learning of private IP ranges. | `bool` | `false` | no |
| <a name="input_base_policy_id"></a> [base\_policy\_id](#input\_base\_policy\_id) | (Optional) ID of the base/parent Firewall Policy.<br/>DEPENDENCY: Parent policy must exist. Used for policy inheritance. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Firewall Policy. | `bool` | `true` | no |
| <a name="input_dns"></a> [dns](#input\_dns) | (Optional) DNS configuration for the policy.<br/><br/>Attributes:<br/>  - proxy\_enabled: Enable DNS proxy.<br/>  - servers: Custom DNS servers. | <pre>object({<br/>    proxy_enabled = optional(bool, true)<br/>    servers       = optional(list(string), null)<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_explicit_proxy"></a> [explicit\_proxy](#input\_explicit\_proxy) | (Optional) Explicit proxy configuration (Premium SKU only).<br/><br/>Attributes:<br/>  - enabled: Enable explicit proxy.<br/>  - http\_port: HTTP port (default 8080).<br/>  - https\_port: HTTPS port (default 8443).<br/>  - enable\_pac\_file: Enable PAC file.<br/>  - pac\_file\_port: PAC file port.<br/>  - pac\_file: PAC file SAS URL. | <pre>object({<br/>    enabled         = optional(bool, true)<br/>    http_port       = optional(number, 8080)<br/>    https_port      = optional(number, 8443)<br/>    enable_pac_file = optional(bool, false)<br/>    pac_file_port   = optional(number, null)<br/>    pac_file        = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Managed identity for Key Vault access (required for TLS inspection).<br/>DEPENDENCY: User-assigned managed identity must exist.<br/><br/>Attributes:<br/>  - type: Identity type (UserAssigned).<br/>  - identity\_ids: List of user-assigned identity IDs. | <pre>object({<br/>    type         = optional(string, "UserAssigned")<br/>    identity_ids = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_insights"></a> [insights](#input\_insights) | (Optional) Policy insights configuration.<br/>DEPENDENCY: Log Analytics workspace must exist.<br/><br/>Attributes:<br/>  - enabled: Enable insights.<br/>  - default\_log\_analytics\_workspace\_id: Default workspace ID.<br/>  - retention\_in\_days: Log retention (30-730 days).<br/>  - log\_analytics\_workspaces: Per-region workspace mappings. | <pre>object({<br/>    enabled                            = optional(bool, true)<br/>    default_log_analytics_workspace_id = string<br/>    retention_in_days                  = optional(number, 30)<br/>    log_analytics_workspaces = optional(list(object({<br/>      id                = string<br/>      firewall_location = string<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_intrusion_detection"></a> [intrusion\_detection](#input\_intrusion\_detection) | (Optional) IDPS configuration (Premium SKU only).<br/><br/>Attributes:<br/>  - mode: Off, Alert, or Deny.<br/>  - private\_ranges: Private IP ranges for IDPS.<br/>  - signature\_overrides: List of signature overrides.<br/>  - traffic\_bypass: Traffic bypass rules. | <pre>object({<br/>    mode           = optional(string, "Alert")<br/>    private_ranges = optional(list(string), null)<br/>    signature_overrides = optional(list(object({<br/>      id    = string<br/>      state = string # Off, Alert, Deny<br/>    })), [])<br/>    traffic_bypass = optional(list(object({<br/>      name                  = string<br/>      protocol              = string<br/>      source_addresses      = optional(list(string), null)<br/>      source_ip_groups      = optional(list(string), null)<br/>      destination_addresses = optional(list(string), null)<br/>      destination_ip_groups = optional(list(string), null)<br/>      destination_ports     = optional(list(string), null)<br/>      description           = optional(string, null)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the Firewall Policy. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"afwp"` | no |
| <a name="input_private_ip_ranges"></a> [private\_ip\_ranges](#input\_private\_ip\_ranges) | (Optional) Private IP ranges for SNAT. Use IANAPrivateRanges for RFC1918. | `list(string)` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) SKU tier: Basic, Standard, or Premium. | `string` | `"Standard"` | no |
| <a name="input_sql_redirect_allowed"></a> [sql\_redirect\_allowed](#input\_sql\_redirect\_allowed) | (Optional) Allow SQL redirect traffic. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_threat_intelligence_allowlist"></a> [threat\_intelligence\_allowlist](#input\_threat\_intelligence\_allowlist) | (Optional) Threat Intelligence allowlist configuration. | <pre>object({<br/>    fqdns        = optional(list(string), [])<br/>    ip_addresses = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_threat_intelligence_mode"></a> [threat\_intelligence\_mode](#input\_threat\_intelligence\_mode) | (Optional) Threat Intelligence mode: Off, Alert, or Deny. | `string` | `"Alert"` | no |
| <a name="input_tls_certificate"></a> [tls\_certificate](#input\_tls\_certificate) | (Optional) TLS inspection certificate (Premium SKU only).<br/>DEPENDENCY: Key Vault certificate must exist.<br/><br/>Attributes:<br/>  - key\_vault\_secret\_id: Key Vault secret ID for the certificate.<br/>  - name: Certificate name. | <pre>object({<br/>    key_vault_secret_id = string<br/>    name                = string<br/>  })</pre> | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"hub"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_child_policies"></a> [child\_policies](#output\_child\_policies) | List of child policy IDs. |
| <a name="output_firewalls"></a> [firewalls](#output\_firewalls) | List of firewall IDs using this policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Firewall Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Firewall Policy. |
| <a name="output_rule_collection_groups"></a> [rule\_collection\_groups](#output\_rule\_collection\_groups) | List of rule collection group IDs. |
<!-- END_TF_DOCS -->