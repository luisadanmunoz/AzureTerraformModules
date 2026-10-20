# Azure Subnet Terraform Module

This module creates an Azure Subnet with optional NSG, Route Table, and NAT Gateway associations, service endpoints, and service delegations.

## Features

- Full subnet configuration with all Azure-supported parameters
- Network Security Group (NSG) association
- Route Table association
- NAT Gateway association
- Service endpoints configuration
- Service delegation for PaaS services
- Private endpoint/link policies
- Flexible naming convention with prefix/suffix support
- `create` flag to enable/disable resource creation

## Dependencies

Before using this module, ensure the following resources exist:

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | The RG containing the VNet |
| Virtual Network | **Yes** | The VNet where the subnet will be created |
| Network Security Group | No | Only if `network_security_group_id` is provided |
| Route Table | No | Only if `route_table_id` is provided |
| NAT Gateway | No | Only if `nat_gateway_id` is provided |
| Service Endpoint Policy | No | Only if `service_endpoint_policy_ids` is provided |

## Usage

### Basic Example

```hcl
module "subnet" {
  source = "../../Networking/Subnet"

  # DEPENDENCIES
  resource_group_name  = "rg-networking-dev-001"
  virtual_network_name = "vnet-main-dev-001"

  name             = "snet-workloads-001"
  address_prefixes = ["10.0.1.0/24"]
}
```

### With Naming Convention

```hcl
module "subnet" {
  source = "../../Networking/Subnet"

  resource_group_name  = "rg-networking-dev-001"
  virtual_network_name = "vnet-main-dev-001"

  # Uses naming convention: snet-web-prod-001
  name_prefix   = "snet"
  workload      = "web"
  environment   = "prod"
  instance      = "001"

  address_prefixes = ["10.0.1.0/24"]
}
```

### With NSG and Route Table Associations

```hcl
module "subnet" {
  source = "../../Networking/Subnet"

  resource_group_name  = "rg-networking-dev-001"
  virtual_network_name = "vnet-main-dev-001"

  name             = "snet-workloads-001"
  address_prefixes = ["10.0.1.0/24"]

  # DEPENDENCIES: These resources must exist
  network_security_group_id = module.nsg.id
  route_table_id            = module.route_table.id
}
```

### With Service Endpoints

```hcl
module "subnet" {
  source = "../../Networking/Subnet"

  resource_group_name  = "rg-networking-dev-001"
  virtual_network_name = "vnet-main-dev-001"

  name             = "snet-data-001"
  address_prefixes = ["10.0.2.0/24"]

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Sql",
    "Microsoft.KeyVault",
    "Microsoft.AzureCosmosDB"
  ]
}
```

### With Service Delegation (App Service)

```hcl
module "subnet_appservice" {
  source = "../../Networking/Subnet"

  resource_group_name  = "rg-networking-dev-001"
  virtual_network_name = "vnet-main-dev-001"

  name             = "snet-appservice-001"
  address_prefixes = ["10.0.3.0/24"]

  delegation = {
    name = "appservice-delegation"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
```

### With Service Delegation (Container Instances)

```hcl
module "subnet_aci" {
  source = "../../Networking/Subnet"

  resource_group_name  = "rg-networking-dev-001"
  virtual_network_name = "vnet-main-dev-001"

  name             = "snet-aci-001"
  address_prefixes = ["10.0.4.0/24"]

  delegation = {
    name = "aci-delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
```

### Private Endpoint Subnet

```hcl
module "subnet_privateendpoints" {
  source = "../../Networking/Subnet"

  resource_group_name  = "rg-networking-dev-001"
  virtual_network_name = "vnet-main-dev-001"

  name             = "snet-privateendpoints-001"
  address_prefixes = ["10.0.250.0/24"]

  # Allow private endpoints
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
}
```

### With NAT Gateway

```hcl
module "subnet" {
  source = "../../Networking/Subnet"

  resource_group_name  = "rg-networking-dev-001"
  virtual_network_name = "vnet-main-dev-001"

  name             = "snet-outbound-001"
  address_prefixes = ["10.0.5.0/24"]

  # DEPENDENCY: NAT Gateway must exist
  nat_gateway_id = module.nat_gateway.id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Subnet | `bool` | `true` | no |
| resource_group_name | Resource Group name (DEPENDENCY) | `string` | n/a | **yes** |
| virtual_network_name | Virtual Network name (DEPENDENCY) | `string` | n/a | **yes** |
| name | Explicit name for the Subnet | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"snet"` | no |
| name_suffix | Suffix for generated name | `string` | `""` | no |
| workload | Workload name for naming convention | `string` | `"default"` | no |
| environment | Environment name for naming convention | `string` | `"dev"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| address_prefixes | List of CIDR blocks for the Subnet | `list(string)` | n/a | **yes** |
| private_endpoint_network_policies | Network policies for private endpoints | `string` | `"Disabled"` | no |
| private_link_service_network_policies_enabled | Network policies for private link services | `bool` | `false` | no |
| default_outbound_access_enabled | Enable default outbound access | `bool` | `true` | no |
| service_endpoints | List of service endpoints | `list(string)` | `[]` | no |
| service_endpoint_policy_ids | Service Endpoint Policy IDs (DEPENDENCY) | `list(string)` | `[]` | no |
| delegation | Service delegation configuration | `object({...})` | `null` | no |
| network_security_group_id | NSG ID for association (DEPENDENCY) | `string` | `null` | no |
| route_table_id | Route Table ID for association (DEPENDENCY) | `string` | `null` | no |
| nat_gateway_id | NAT Gateway ID for association (DEPENDENCY) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Subnet |
| name | The name of the Subnet |
| resource_group_name | The Resource Group name |
| virtual_network_name | The Virtual Network name |
| address_prefixes | The address prefixes |
| nsg_association_id | ID of NSG association (if created) |
| route_table_association_id | ID of Route Table association (if created) |
| nat_gateway_association_id | ID of NAT Gateway association (if created) |

## Common Service Delegations

| Service | Delegation Name |
|---------|-----------------|
| App Service / Functions | `Microsoft.Web/serverFarms` |
| Container Instances | `Microsoft.ContainerInstance/containerGroups` |
| SQL Managed Instance | `Microsoft.Sql/managedInstances` |
| Azure Databricks | `Microsoft.Databricks/workspaces` |
| Azure NetApp Files | `Microsoft.Netapp/volumes` |
| PostgreSQL Flexible | `Microsoft.DBforPostgreSQL/flexibleServers` |
| MySQL Flexible | `Microsoft.DBforMySQL/flexibleServers` |
| API Management | `Microsoft.ApiManagement/service` |
| Azure Kubernetes Service | `Microsoft.ContainerService/managedClusters` |

## Security Recommendations

1. **Always associate an NSG**: Every subnet should have an NSG for traffic filtering
2. **Use Route Tables**: Control traffic flow with custom routes where needed
3. **Enable Service Endpoints**: Secure Azure PaaS access over the Azure backbone
4. **Dedicated Subnets for Private Endpoints**: Use separate subnets for private endpoints
5. **Proper CIDR Planning**: Plan address spaces to avoid overlap and allow growth
6. **Minimize Delegation**: Only delegate subnets when required by the service

## Notes

- Address prefixes must be within the VNet's address space
- Some services require specific subnet sizes (e.g., Azure SQL MI needs /27 minimum)
- Delegated subnets may have restrictions on other resources
- Service endpoints require subnet-level configuration

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
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | (Required) The list of address prefixes (CIDR blocks) for the Subnet.<br/>Must be within the Virtual Network's address space.<br/>Example: ["10.0.1.0/24"] | `list(string)` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Subnet. Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_default_outbound_access_enabled"></a> [default\_outbound\_access\_enabled](#input\_default\_outbound\_access\_enabled) | (Optional) Enable or disable default outbound access. Defaults to true. | `bool` | `true` | no |
| <a name="input_delegation"></a> [delegation](#input\_delegation) | (Optional) Service delegation configuration for the subnet.<br/>Used when the subnet needs to be delegated to a specific Azure service.<br/><br/>Attributes:<br/>  - name: A name for the delegation.<br/>  - service\_delegation: The service delegation configuration.<br/>    - name: The name of the service to delegate to.<br/>    - actions: List of actions permitted to the service.<br/><br/>Common delegations:<br/>- Microsoft.Web/serverFarms (App Service)<br/>- Microsoft.ContainerInstance/containerGroups (ACI)<br/>- Microsoft.Sql/managedInstances (SQL MI)<br/>- Microsoft.DBforMySQL/flexibleServers (MySQL Flexible)<br/>- Microsoft.DBforPostgreSQL/flexibleServers (PostgreSQL Flexible)<br/>- Microsoft.Netapp/volumes (Azure NetApp Files) | <pre>object({<br/>    name = string<br/>    service_delegation = object({<br/>      name    = string<br/>      actions = optional(list(string), ["Microsoft.Network/virtualNetworks/subnets/action"])<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod), used for naming convention. | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Subnet. If provided, overrides name\_prefix/name\_suffix logic. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix to prepend to the generated Subnet name. Used when 'name' is not provided. | `string` | `"snet"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix to append to the generated Subnet name. Used when 'name' is not provided. | `string` | `""` | no |
| <a name="input_nat_gateway_id"></a> [nat\_gateway\_id](#input\_nat\_gateway\_id) | (Optional) The ID of the NAT Gateway to associate with the subnet.<br/>DEPENDENCY: NAT Gateway must exist before association. | `string` | `null` | no |
| <a name="input_network_security_group_id"></a> [network\_security\_group\_id](#input\_network\_security\_group\_id) | (Optional) The ID of the Network Security Group to associate with the subnet.<br/>DEPENDENCY: NSG must exist before association. | `string` | `null` | no |
| <a name="input_private_endpoint_network_policies"></a> [private\_endpoint\_network\_policies](#input\_private\_endpoint\_network\_policies) | (Optional) Enable or disable network policies for private endpoints.<br/>Possible values: "Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled".<br/>Set to "Disabled" to allow private endpoints in the subnet. | `string` | `"Disabled"` | no |
| <a name="input_private_link_service_network_policies_enabled"></a> [private\_link\_service\_network\_policies\_enabled](#input\_private\_link\_service\_network\_policies\_enabled) | (Optional) Enable or disable network policies for private link services. Set to false to allow private link services. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group containing the Virtual Network.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | (Optional) The ID of the Route Table to associate with the subnet.<br/>DEPENDENCY: Route Table must exist before association. | `string` | `null` | no |
| <a name="input_service_endpoint_policy_ids"></a> [service\_endpoint\_policy\_ids](#input\_service\_endpoint\_policy\_ids) | (Optional) List of Service Endpoint Policy IDs to associate with the subnet.<br/>DEPENDENCY: Service Endpoint Policies must exist before referencing. | `list(string)` | `[]` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | (Optional) List of service endpoints to associate with the subnet.<br/>Example: ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]<br/><br/>Available endpoints:<br/>- Microsoft.AzureActiveDirectory<br/>- Microsoft.AzureCosmosDB<br/>- Microsoft.ContainerRegistry<br/>- Microsoft.EventHub<br/>- Microsoft.KeyVault<br/>- Microsoft.ServiceBus<br/>- Microsoft.Sql<br/>- Microsoft.Storage<br/>- Microsoft.Storage.Global<br/>- Microsoft.Web | `list(string)` | `[]` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | (Required) The name of the Virtual Network where the Subnet will be created.<br/>DEPENDENCY: Virtual Network must exist before creating the Subnet. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or purpose name, used for naming convention. | `string` | `"default"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_address_prefixes"></a> [address\_prefixes](#output\_address\_prefixes) | The address prefixes configured for the Subnet. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Subnet. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Subnet. |
| <a name="output_nat_gateway_association_id"></a> [nat\_gateway\_association\_id](#output\_nat\_gateway\_association\_id) | The ID of the NAT Gateway association (if created). |
| <a name="output_nsg_association_id"></a> [nsg\_association\_id](#output\_nsg\_association\_id) | The ID of the NSG association (if created). |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group containing the Subnet. |
| <a name="output_route_table_association_id"></a> [route\_table\_association\_id](#output\_route\_table\_association\_id) | The ID of the Route Table association (if created). |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The name of the Virtual Network containing the Subnet. |
<!-- END_TF_DOCS -->