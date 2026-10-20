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
