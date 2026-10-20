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
