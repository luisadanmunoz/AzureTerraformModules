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
