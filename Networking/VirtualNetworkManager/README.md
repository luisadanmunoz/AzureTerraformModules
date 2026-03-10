# Azure Virtual Network Manager Terraform Module

This module creates an Azure Virtual Network Manager (AVNM) with optional network groups, connectivity configurations, security admin configurations, rule collections, and admin rules.

## Features

- Fully configurable Virtual Network Manager with scope and access controls
- Network Groups with optional static VNet membership
- Connectivity Configurations supporting both Hub-and-Spoke and Mesh topologies
- Security Admin Configurations with rule collections and admin rules
- Flexible naming convention with prefix/workload/environment/instance support
- `create` flag to enable/disable resource creation

## Dependencies

Before using this module, ensure the following resources exist:

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | The Virtual Network Manager must be created within an existing Resource Group |
| Management Group / Subscription | **Yes** | At least one must be in scope |
| Virtual Networks | No | Only if adding static members to Network Groups |
| Hub Virtual Network | No | Only if using HubAndSpoke connectivity topology |

## Usage

### Basic Example

```hcl
module "vnm" {
  source = "../../Networking/VirtualNetworkManager"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name           = "vnm-hub-dev-001"
  scope_accesses = ["Connectivity"]

  scope = {
    subscription_ids = ["/subscriptions/00000000-0000-0000-0000-000000000000"]
  }

  tags = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
```

### With Naming Convention

```hcl
module "vnm" {
  source = "../../Networking/VirtualNetworkManager"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  # Uses naming convention: vnm-hub-prod-vnm-001
  name_prefix   = "vnm"
  workload      = "hub"
  environment   = "prod"
  instance      = "001"

  scope_accesses = ["Connectivity", "SecurityAdmin"]

  scope = {
    subscription_ids = ["/subscriptions/00000000-0000-0000-0000-000000000000"]
  }
}
```

### With Network Groups and Connectivity Configuration

```hcl
module "vnm" {
  source = "../../Networking/VirtualNetworkManager"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"
  name                = "vnm-hub-prod-001"
  scope_accesses      = ["Connectivity"]

  scope = {
    subscription_ids = ["/subscriptions/00000000-0000-0000-0000-000000000000"]
  }

  network_groups = [
    {
      name        = "ng-spoke-vnets"
      description = "Network group for spoke virtual networks"
      static_members = [
        {
          name                      = "spoke-vnet-001"
          target_virtual_network_id = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/virtualNetworks/vnet-spoke-001"
        }
      ]
    }
  ]

  connectivity_configurations = [
    {
      name                  = "cc-hub-spoke"
      connectivity_topology = "HubAndSpoke"
      applies_to_group = [
        {
          group_connectivity = "None"
          network_group_id   = "ng-spoke-vnets"
        }
      ]
      hub = {
        resource_id = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/virtualNetworks/vnet-hub-001"
      }
    }
  ]
}
```

### With Security Admin Configuration

```hcl
module "vnm" {
  source = "../../Networking/VirtualNetworkManager"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"
  name                = "vnm-security-prod-001"
  scope_accesses      = ["SecurityAdmin"]

  scope = {
    subscription_ids = ["/subscriptions/00000000-0000-0000-0000-000000000000"]
  }

  security_admin_configurations = [
    {
      name        = "sac-baseline"
      description = "Baseline security admin configuration"
      rule_collections = [
        {
          name              = "rc-deny-inbound"
          description       = "Deny high-risk inbound traffic"
          network_group_ids = ["/subscriptions/xxx/providers/Microsoft.Network/networkManagers/xxx/networkGroups/ng-all"]
          rules = [
            {
              name        = "deny-ssh-inbound"
              description = "Deny SSH from internet"
              action      = "Deny"
              direction   = "Inbound"
              priority    = 100
              protocol    = "Tcp"
              destination_port_ranges = ["22"]
              source = [
                {
                  address_prefix      = "Internet"
                  address_prefix_type = "ServiceTag"
                }
              ]
              destination = [
                {
                  address_prefix      = "*"
                  address_prefix_type = "IPPrefix"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

### Disabled Module (for conditional creation)

```hcl
module "vnm" {
  source = "../../Networking/VirtualNetworkManager"

  create = false  # Resources will not be created

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  scope_accesses      = ["Connectivity"]

  scope = {
    subscription_ids = ["/subscriptions/00000000-0000-0000-0000-000000000000"]
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Virtual Network Manager | `bool` | `true` | no |
| resource_group_name | The name of the Resource Group (DEPENDENCY) | `string` | n/a | **yes** |
| location | The Azure region for deployment (DEPENDENCY) | `string` | n/a | **yes** |
| name | Explicit name for the Virtual Network Manager | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"vnm"` | no |
| workload | Workload name for naming convention | `string` | `"shared"` | no |
| environment | Environment name for naming convention | `string` | `"dev"` | no |
| instance | Instance identifier for naming convention | `string` | `"001"` | no |
| scope_accesses | List of deployment types (Connectivity, SecurityAdmin) | `list(string)` | n/a | **yes** |
| scope | Scope with management_group_ids and/or subscription_ids | `object({...})` | n/a | **yes** |
| description | Description of the Virtual Network Manager | `string` | `null` | no |
| network_groups | List of Network Groups to create | `list(object({...}))` | `[]` | no |
| connectivity_configurations | List of Connectivity Configurations | `list(object({...}))` | `[]` | no |
| security_admin_configurations | List of Security Admin Configurations | `list(object({...}))` | `[]` | no |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Virtual Network Manager |
| name | The name of the Virtual Network Manager |
| cross_tenant_scopes | The cross-tenant scopes of the Virtual Network Manager |
| network_group_ids | Map of Network Group names to their IDs |
| connectivity_configuration_ids | Map of Connectivity Configuration names to their IDs |
| security_admin_configuration_ids | Map of Security Admin Configuration names to their IDs |
| admin_rule_collection_ids | Map of Admin Rule Collection names to their IDs |

## Security Recommendations

1. **Scope Management**: Use the principle of least privilege when defining scope - only include subscriptions and management groups that require network management
2. **Security Admin Rules**: Use Security Admin Configurations to enforce baseline network security policies across all managed VNets
3. **Hub-and-Spoke**: For production environments, use Hub-and-Spoke topology with centralized network security appliances
4. **Rule Priority**: Plan admin rule priorities carefully - lower numbers have higher priority
5. **Monitoring**: Monitor Virtual Network Manager operations through Azure Activity Log

## Notes

- Virtual Network Manager requires the `Microsoft.Network` resource provider to be registered
- Connectivity and Security Admin configurations must be deployed separately after creation using deployment resources
- Network Group membership can be defined statically (via static_members) or dynamically using Azure Policy (outside this module)
- The `scope_accesses` determine which configuration types can be created - include both if you need Connectivity and SecurityAdmin
