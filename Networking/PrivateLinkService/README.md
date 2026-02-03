# Azure Private Link Service Terraform Module

This module creates an Azure Private Link Service for exposing services privately to consumers
via Azure Private Endpoints across subscriptions and tenants.

## Features

- Private Link Service creation backed by a Standard Load Balancer
- NAT IP configuration with support for multiple NAT IPs
- Auto-approval and visibility controls per subscription
- Proxy Protocol support for preserving client connection information
- Custom FQDN association
- Flexible naming convention

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Standard Load Balancer | **Yes** | Must exist with at least one frontend IP configuration |
| Subnet | **Yes** | Must have private link service network policies disabled |

## Usage

### Basic Private Link Service

```hcl
module "private_link_service" {
  source = "../../Networking/PrivateLinkService"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name = "pls-myapp-dev-001"

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.example.frontend_ip_configuration[0].id
  ]

  nat_ip_configuration = [
    {
      name      = "nat-primary"
      subnet_id = azurerm_subnet.pls.id
      primary   = true
    }
  ]
}
```

### With Auto-Approval and Visibility

```hcl
module "private_link_service" {
  source = "../../Networking/PrivateLinkService"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  name = "pls-myapp-prod-001"

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.example.frontend_ip_configuration[0].id
  ]

  nat_ip_configuration = [
    {
      name      = "nat-primary"
      subnet_id = azurerm_subnet.pls.id
      primary   = true
    },
    {
      name      = "nat-secondary"
      subnet_id = azurerm_subnet.pls.id
      primary   = false
    }
  ]

  auto_approval_subscription_ids = [
    "00000000-0000-0000-0000-000000000001",
    "00000000-0000-0000-0000-000000000002"
  ]

  visibility_subscription_ids = [
    "00000000-0000-0000-0000-000000000001",
    "00000000-0000-0000-0000-000000000002",
    "00000000-0000-0000-0000-000000000003"
  ]

  enable_proxy_protocol = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"pls"` | no |
| name_suffix | Suffix for generated name | `string` | `""` | no |
| workload | Workload name for naming convention | `string` | `"default"` | no |
| environment | Environment name | `string` | `"dev"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| load_balancer_frontend_ip_configuration_ids | Frontend IP Configuration IDs from a Standard LB | `list(string)` | n/a | **yes** |
| nat_ip_configuration | NAT IP configuration blocks | `list(object({...}))` | n/a | **yes** |
| auto_approval_subscription_ids | Subscription IDs for auto-approval | `list(string)` | `null` | no |
| visibility_subscription_ids | Subscription IDs for visibility | `list(string)` | `null` | no |
| enable_proxy_protocol | Enable Proxy Protocol | `bool` | `false` | no |
| fqdns | FQDNs for the Private Link Service | `list(string)` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Private Link Service ID |
| name | Private Link Service name |
| alias | Private Link Service alias (used by consumers to connect) |

## Architecture Notes

1. **Standard Load Balancer**: Private Link Service requires a Standard SKU Load Balancer
2. **NAT Subnet**: The subnet used for NAT IP configuration must have `private_link_service_network_policies_enabled` set to `false`
3. **Primary NAT IP**: Exactly one NAT IP configuration must be marked as primary
4. **Proxy Protocol**: Enable when you need to preserve the original client IP address
5. **Alias**: The alias output is used by consumers to create Private Endpoint connections to this service
