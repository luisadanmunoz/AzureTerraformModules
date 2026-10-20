################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Subnet. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group containing the Virtual Network.
    DEPENDENCY: Resource Group must exist.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required and cannot be empty."
  }
}

variable "virtual_network_name" {
  description = <<-EOT
    (Required) The name of the Virtual Network where the Subnet will be created.
    DEPENDENCY: Virtual Network must exist before creating the Subnet.
  EOT
  type        = string

  validation {
    condition     = var.virtual_network_name != null && var.virtual_network_name != ""
    error_message = "virtual_network_name is required and cannot be empty."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the Subnet. If provided, overrides name_prefix/name_suffix logic."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated Subnet name. Used when 'name' is not provided."
  type        = string
  default     = "snet"
}

variable "name_suffix" {
  description = "(Optional) Suffix to append to the generated Subnet name. Used when 'name' is not provided."
  type        = string
  default     = ""
}

variable "workload" {
  description = "(Optional) The workload or purpose name, used for naming convention."
  type        = string
  default     = "default"
}

variable "environment" {
  description = "(Optional) The environment name (e.g., dev, staging, prod), used for naming convention."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number or identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Subnet Configuration
################################################################################

variable "address_prefixes" {
  description = <<-EOT
    (Required) The list of address prefixes (CIDR blocks) for the Subnet.
    Must be within the Virtual Network's address space.
    Example: ["10.0.1.0/24"]
  EOT
  type        = list(string)

  validation {
    condition     = length(var.address_prefixes) > 0
    error_message = "At least one address prefix must be provided."
  }
}

variable "private_endpoint_network_policies" {
  description = <<-EOT
    (Optional) Enable or disable network policies for private endpoints.
    Possible values: "Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled".
    Set to "Disabled" to allow private endpoints in the subnet.
  EOT
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.private_endpoint_network_policies)
    error_message = "private_endpoint_network_policies must be one of: Disabled, Enabled, NetworkSecurityGroupEnabled, RouteTableEnabled."
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "(Optional) Enable or disable network policies for private link services. Set to false to allow private link services."
  type        = bool
  default     = false
}

variable "default_outbound_access_enabled" {
  description = "(Optional) Enable or disable default outbound access. Defaults to true."
  type        = bool
  default     = true
}

################################################################################
# Service Endpoints
################################################################################

variable "service_endpoints" {
  description = <<-EOT
    (Optional) List of service endpoints to associate with the subnet.
    Example: ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql"]

    Available endpoints:
    - Microsoft.AzureActiveDirectory
    - Microsoft.AzureCosmosDB
    - Microsoft.ContainerRegistry
    - Microsoft.EventHub
    - Microsoft.KeyVault
    - Microsoft.ServiceBus
    - Microsoft.Sql
    - Microsoft.Storage
    - Microsoft.Storage.Global
    - Microsoft.Web
  EOT
  type        = list(string)
  default     = []
}

variable "service_endpoint_policy_ids" {
  description = <<-EOT
    (Optional) List of Service Endpoint Policy IDs to associate with the subnet.
    DEPENDENCY: Service Endpoint Policies must exist before referencing.
  EOT
  type        = list(string)
  default     = []
}

################################################################################
# Service Delegation
################################################################################

variable "delegation" {
  description = <<-EOT
    (Optional) Service delegation configuration for the subnet.
    Used when the subnet needs to be delegated to a specific Azure service.

    Attributes:
      - name: A name for the delegation.
      - service_delegation: The service delegation configuration.
        - name: The name of the service to delegate to.
        - actions: List of actions permitted to the service.

    Common delegations:
    - Microsoft.Web/serverFarms (App Service)
    - Microsoft.ContainerInstance/containerGroups (ACI)
    - Microsoft.Sql/managedInstances (SQL MI)
    - Microsoft.DBforMySQL/flexibleServers (MySQL Flexible)
    - Microsoft.DBforPostgreSQL/flexibleServers (PostgreSQL Flexible)
    - Microsoft.Netapp/volumes (Azure NetApp Files)
  EOT
  type = object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string), ["Microsoft.Network/virtualNetworks/subnets/action"])
    })
  })
  default = null
}

################################################################################
# NSG and Route Table Associations
################################################################################

variable "network_security_group_id" {
  description = <<-EOT
    (Optional) The ID of the Network Security Group to associate with the subnet.
    DEPENDENCY: NSG must exist before association.
  EOT
  type        = string
  default     = null
}

variable "route_table_id" {
  description = <<-EOT
    (Optional) The ID of the Route Table to associate with the subnet.
    DEPENDENCY: Route Table must exist before association.
  EOT
  type        = string
  default     = null
}

################################################################################
# NAT Gateway Association
################################################################################

variable "nat_gateway_id" {
  description = <<-EOT
    (Optional) The ID of the NAT Gateway to associate with the subnet.
    DEPENDENCY: NAT Gateway must exist before association.
  EOT
  type        = string
  default     = null
}
