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
| [azurerm_network_manager.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_manager) | resource |
| [azurerm_network_manager_admin_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_manager_admin_rule) | resource |
| [azurerm_network_manager_admin_rule_collection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_manager_admin_rule_collection) | resource |
| [azurerm_network_manager_connectivity_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_manager_connectivity_configuration) | resource |
| [azurerm_network_manager_network_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_manager_network_group) | resource |
| [azurerm_network_manager_security_admin_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_manager_security_admin_configuration) | resource |
| [azurerm_network_manager_static_member.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_manager_static_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_connectivity_configurations"></a> [connectivity\_configurations](#input\_connectivity\_configurations) | (Optional) A list of Connectivity Configurations for the Virtual Network Manager.<br/><br/>Attributes:<br/>  - name:                          (Required) The name of the connectivity configuration.<br/>  - network\_group\_id:              (Required) The ID of the Network Group to associate.<br/>  - connectivity\_topology:         (Required) The connectivity topology type. Possible values: "HubAndSpoke", "Mesh".<br/>  - applies\_to\_group:              (Required) A list of groups the configuration applies to.<br/>    - group\_connectivity:  (Required) The group connectivity type. Possible values: "None", "DirectlyConnected".<br/>    - network\_group\_id:    (Required) The ID of the Network Group.<br/>    - use\_hub\_gateway:     (Optional) Whether to use the hub's gateway. Defaults to false.<br/>    - global\_mesh\_enabled: (Optional) Whether global mesh is enabled. Defaults to false.<br/>  - hub:                           (Optional) Hub configuration for HubAndSpoke topology.<br/>    - resource\_id:   (Required) The resource ID of the hub Virtual Network.<br/>    - resource\_type:  (Optional) The resource type. Defaults to "Microsoft.Network/virtualNetworks".<br/>  - delete\_existing\_peering\_enabled: (Optional) Whether to delete existing peerings. Defaults to false.<br/>  - global\_mesh\_enabled:           (Optional) Whether global mesh is enabled at the configuration level. Defaults to false.<br/>  - description:                   (Optional) A description of the connectivity configuration. | <pre>list(object({<br/>    name                  = string<br/>    network_group_id      = optional(string, null)<br/>    connectivity_topology = string<br/>    applies_to_group = list(object({<br/>      group_connectivity  = string<br/>      network_group_id    = string<br/>      use_hub_gateway     = optional(bool, false)<br/>      global_mesh_enabled = optional(bool, false)<br/>    }))<br/>    hub = optional(object({<br/>      resource_id   = string<br/>      resource_type = optional(string, "Microsoft.Network/virtualNetworks")<br/>    }), null)<br/>    delete_existing_peering_enabled = optional(bool, false)<br/>    global_mesh_enabled             = optional(bool, false)<br/>    description                     = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Virtual Network Manager. Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the Virtual Network Manager. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod), used for naming convention. | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the Virtual Network Manager will be deployed.<br/>DEPENDENCY: Should match the Resource Group location for optimal performance. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Virtual Network Manager. If provided, overrides the generated name from name\_prefix/workload/environment/instance. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix to prepend to the generated Virtual Network Manager name. Used when 'name' is not provided. | `string` | `"vnm"` | no |
| <a name="input_network_groups"></a> [network\_groups](#input\_network\_groups) | (Optional) A list of Network Groups to create within the Virtual Network Manager.<br/><br/>Attributes:<br/>  - name:           (Required) The name of the Network Group.<br/>  - description:    (Optional) A description of the Network Group.<br/>  - static\_members: (Optional) A list of objects defining static VNet members.<br/>    - name:                  (Required) The name of the static member entry.<br/>    - target\_virtual\_network\_id: (Required) The resource ID of the VNet to add. | <pre>list(object({<br/>    name        = string<br/>    description = optional(string, null)<br/>    static_members = optional(list(object({<br/>      name                      = string<br/>      target_virtual_network_id = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Virtual Network Manager will be created.<br/>DEPENDENCY: Resource Group must exist before creating the Virtual Network Manager. | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | (Required) The scope of the Virtual Network Manager. At least one of management\_group\_ids or subscription\_ids must be provided.<br/><br/>Attributes:<br/>  - management\_group\_ids: (Optional) List of Management Group IDs to include in scope.<br/>  - subscription\_ids:     (Optional) List of Subscription IDs to include in scope. | <pre>object({<br/>    management_group_ids = optional(list(string), [])<br/>    subscription_ids     = optional(list(string), [])<br/>  })</pre> | n/a | yes |
| <a name="input_scope_accesses"></a> [scope\_accesses](#input\_scope\_accesses) | (Required) A list of configuration deployment types permitted by this Network Manager.<br/>Possible values: "Connectivity", "SecurityAdmin". | `list(string)` | n/a | yes |
| <a name="input_security_admin_configurations"></a> [security\_admin\_configurations](#input\_security\_admin\_configurations) | (Optional) A list of Security Admin Configurations for the Virtual Network Manager.<br/><br/>Attributes:<br/>  - name:        (Required) The name of the security admin configuration.<br/>  - description: (Optional) A description of the security admin configuration.<br/>  - rule\_collections: (Optional) A list of rule collections within this configuration.<br/>    - name:             (Required) The name of the rule collection.<br/>    - description:      (Optional) A description of the rule collection.<br/>    - network\_group\_ids: (Required) A list of Network Group IDs the rules apply to.<br/>    - rules:            (Optional) A list of admin rules within this collection.<br/>      - name:                    (Required) The name of the rule.<br/>      - description:             (Optional) A description of the rule.<br/>      - action:                  (Required) The action. Possible values: "Allow", "Deny", "AlwaysAllow".<br/>      - direction:               (Required) The direction. Possible values: "Inbound", "Outbound".<br/>      - priority:                (Required) The priority (1-4096).<br/>      - protocol:                (Required) The protocol. Possible values: "Tcp", "Udp", "Icmp", "Esp", "Any", "Ah".<br/>      - source\_port\_ranges:      (Optional) List of source port ranges. Defaults to ["*"].<br/>      - destination\_port\_ranges: (Optional) List of destination port ranges. Defaults to ["*"].<br/>      - source:                  (Optional) List of source address prefixes.<br/>        - address\_prefix:      (Required) The address prefix.<br/>        - address\_prefix\_type: (Required) The type. Possible values: "IPPrefix", "ServiceTag".<br/>      - destination:             (Optional) List of destination address prefixes.<br/>        - address\_prefix:      (Required) The address prefix.<br/>        - address\_prefix\_type: (Required) The type. Possible values: "IPPrefix", "ServiceTag". | <pre>list(object({<br/>    name        = string<br/>    description = optional(string, null)<br/>    rule_collections = optional(list(object({<br/>      name              = string<br/>      description       = optional(string, null)<br/>      network_group_ids = list(string)<br/>      rules = optional(list(object({<br/>        name                    = string<br/>        description             = optional(string, null)<br/>        action                  = string<br/>        direction               = string<br/>        priority                = number<br/>        protocol                = string<br/>        source_port_ranges      = optional(list(string), ["*"])<br/>        destination_port_ranges = optional(list(string), ["*"])<br/>        source = optional(list(object({<br/>          address_prefix      = string<br/>          address_prefix_type = string<br/>        })), [])<br/>        destination = optional(list(object({<br/>          address_prefix      = string<br/>          address_prefix_type = string<br/>        })), [])<br/>      })), [])<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the Virtual Network Manager and related resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or application name, used for naming convention. | `string` | `"shared"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_admin_rule_collection_ids"></a> [admin\_rule\_collection\_ids](#output\_admin\_rule\_collection\_ids) | A map of Admin Rule Collection names to their IDs. |
| <a name="output_connectivity_configuration_ids"></a> [connectivity\_configuration\_ids](#output\_connectivity\_configuration\_ids) | A map of Connectivity Configuration names to their IDs. |
| <a name="output_cross_tenant_scopes"></a> [cross\_tenant\_scopes](#output\_cross\_tenant\_scopes) | The cross-tenant scopes of the Virtual Network Manager. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Network Manager. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Virtual Network Manager. |
| <a name="output_network_group_ids"></a> [network\_group\_ids](#output\_network\_group\_ids) | A map of Network Group names to their IDs. |
| <a name="output_security_admin_configuration_ids"></a> [security\_admin\_configuration\_ids](#output\_security\_admin\_configuration\_ids) | A map of Security Admin Configuration names to their IDs. |
<!-- END_TF_DOCS -->