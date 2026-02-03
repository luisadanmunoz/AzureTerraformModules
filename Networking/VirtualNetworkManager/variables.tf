################################################################################
# Module Control
################################################################################

variable "create" {
  description = "Controls whether to create the Virtual Network Manager. Set to false to disable resource creation without removing module code."
  type        = bool
  default     = true
}

################################################################################
# Required Variables - Dependencies
################################################################################

variable "resource_group_name" {
  description = <<-EOT
    (Required) The name of the Resource Group where the Virtual Network Manager will be created.
    DEPENDENCY: Resource Group must exist before creating the Virtual Network Manager.
  EOT
  type        = string

  validation {
    condition     = var.resource_group_name != null && var.resource_group_name != ""
    error_message = "resource_group_name is required and cannot be empty."
  }
}

variable "location" {
  description = <<-EOT
    (Required) The Azure region where the Virtual Network Manager will be deployed.
    DEPENDENCY: Should match the Resource Group location for optimal performance.
  EOT
  type        = string

  validation {
    condition     = var.location != null && var.location != ""
    error_message = "location is required and cannot be empty."
  }
}

################################################################################
# Naming Variables
################################################################################

variable "name" {
  description = "(Optional) The explicit name for the Virtual Network Manager. If provided, overrides the generated name from name_prefix/workload/environment/instance."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix to prepend to the generated Virtual Network Manager name. Used when 'name' is not provided."
  type        = string
  default     = "vnm"
}

variable "workload" {
  description = "(Optional) The workload or application name, used for naming convention."
  type        = string
  default     = "shared"
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
# Virtual Network Manager Configuration
################################################################################

variable "scope_accesses" {
  description = <<-EOT
    (Required) A list of configuration deployment types permitted by this Network Manager.
    Possible values: "Connectivity", "SecurityAdmin".
  EOT
  type        = list(string)

  validation {
    condition     = length(var.scope_accesses) > 0
    error_message = "At least one scope_access must be provided."
  }

  validation {
    condition     = alltrue([for sa in var.scope_accesses : contains(["Connectivity", "SecurityAdmin"], sa)])
    error_message = "scope_accesses must contain only 'Connectivity' and/or 'SecurityAdmin'."
  }
}

variable "scope" {
  description = <<-EOT
    (Required) The scope of the Virtual Network Manager. At least one of management_group_ids or subscription_ids must be provided.

    Attributes:
      - management_group_ids: (Optional) List of Management Group IDs to include in scope.
      - subscription_ids:     (Optional) List of Subscription IDs to include in scope.
  EOT
  type = object({
    management_group_ids = optional(list(string), [])
    subscription_ids     = optional(list(string), [])
  })

  validation {
    condition     = length(coalesce(var.scope.management_group_ids, [])) > 0 || length(coalesce(var.scope.subscription_ids, [])) > 0
    error_message = "At least one of management_group_ids or subscription_ids must be provided in scope."
  }
}

variable "description" {
  description = "(Optional) A description of the Virtual Network Manager."
  type        = string
  default     = null
}

################################################################################
# Network Groups
################################################################################

variable "network_groups" {
  description = <<-EOT
    (Optional) A list of Network Groups to create within the Virtual Network Manager.

    Attributes:
      - name:           (Required) The name of the Network Group.
      - description:    (Optional) A description of the Network Group.
      - static_members: (Optional) A list of objects defining static VNet members.
        - name:                  (Required) The name of the static member entry.
        - target_virtual_network_id: (Required) The resource ID of the VNet to add.
  EOT
  type = list(object({
    name        = string
    description = optional(string, null)
    static_members = optional(list(object({
      name                      = string
      target_virtual_network_id = string
    })), [])
  }))
  default = []
}

################################################################################
# Connectivity Configurations
################################################################################

variable "connectivity_configurations" {
  description = <<-EOT
    (Optional) A list of Connectivity Configurations for the Virtual Network Manager.

    Attributes:
      - name:                          (Required) The name of the connectivity configuration.
      - network_group_id:              (Required) The ID of the Network Group to associate.
      - connectivity_topology:         (Required) The connectivity topology type. Possible values: "HubAndSpoke", "Mesh".
      - applies_to_group:              (Required) A list of groups the configuration applies to.
        - group_connectivity:  (Required) The group connectivity type. Possible values: "None", "DirectlyConnected".
        - network_group_id:    (Required) The ID of the Network Group.
        - use_hub_gateway:     (Optional) Whether to use the hub's gateway. Defaults to false.
        - global_mesh_enabled: (Optional) Whether global mesh is enabled. Defaults to false.
      - hub:                           (Optional) Hub configuration for HubAndSpoke topology.
        - resource_id:   (Required) The resource ID of the hub Virtual Network.
        - resource_type:  (Optional) The resource type. Defaults to "Microsoft.Network/virtualNetworks".
      - delete_existing_peering_enabled: (Optional) Whether to delete existing peerings. Defaults to false.
      - global_mesh_enabled:           (Optional) Whether global mesh is enabled at the configuration level. Defaults to false.
      - description:                   (Optional) A description of the connectivity configuration.
  EOT
  type = list(object({
    name                  = string
    network_group_id      = optional(string, null)
    connectivity_topology = string
    applies_to_group = list(object({
      group_connectivity  = string
      network_group_id    = string
      use_hub_gateway     = optional(bool, false)
      global_mesh_enabled = optional(bool, false)
    }))
    hub = optional(object({
      resource_id   = string
      resource_type = optional(string, "Microsoft.Network/virtualNetworks")
    }), null)
    delete_existing_peering_enabled = optional(bool, false)
    global_mesh_enabled             = optional(bool, false)
    description                     = optional(string, null)
  }))
  default = []

  validation {
    condition     = alltrue([for cc in var.connectivity_configurations : contains(["HubAndSpoke", "Mesh"], cc.connectivity_topology)])
    error_message = "connectivity_topology must be either 'HubAndSpoke' or 'Mesh'."
  }
}

################################################################################
# Security Admin Configurations
################################################################################

variable "security_admin_configurations" {
  description = <<-EOT
    (Optional) A list of Security Admin Configurations for the Virtual Network Manager.

    Attributes:
      - name:        (Required) The name of the security admin configuration.
      - description: (Optional) A description of the security admin configuration.
      - rule_collections: (Optional) A list of rule collections within this configuration.
        - name:             (Required) The name of the rule collection.
        - description:      (Optional) A description of the rule collection.
        - network_group_ids: (Required) A list of Network Group IDs the rules apply to.
        - rules:            (Optional) A list of admin rules within this collection.
          - name:                    (Required) The name of the rule.
          - description:             (Optional) A description of the rule.
          - action:                  (Required) The action. Possible values: "Allow", "Deny", "AlwaysAllow".
          - direction:               (Required) The direction. Possible values: "Inbound", "Outbound".
          - priority:                (Required) The priority (1-4096).
          - protocol:                (Required) The protocol. Possible values: "Tcp", "Udp", "Icmp", "Esp", "Any", "Ah".
          - source_port_ranges:      (Optional) List of source port ranges. Defaults to ["*"].
          - destination_port_ranges: (Optional) List of destination port ranges. Defaults to ["*"].
          - source:                  (Optional) List of source address prefixes.
            - address_prefix:      (Required) The address prefix.
            - address_prefix_type: (Required) The type. Possible values: "IPPrefix", "ServiceTag".
          - destination:             (Optional) List of destination address prefixes.
            - address_prefix:      (Required) The address prefix.
            - address_prefix_type: (Required) The type. Possible values: "IPPrefix", "ServiceTag".
  EOT
  type = list(object({
    name        = string
    description = optional(string, null)
    rule_collections = optional(list(object({
      name              = string
      description       = optional(string, null)
      network_group_ids = list(string)
      rules = optional(list(object({
        name                    = string
        description             = optional(string, null)
        action                  = string
        direction               = string
        priority                = number
        protocol                = string
        source_port_ranges      = optional(list(string), ["*"])
        destination_port_ranges = optional(list(string), ["*"])
        source = optional(list(object({
          address_prefix      = string
          address_prefix_type = string
        })), [])
        destination = optional(list(object({
          address_prefix      = string
          address_prefix_type = string
        })), [])
      })), [])
    })), [])
  }))
  default = []
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A map of tags to assign to the Virtual Network Manager and related resources."
  type        = map(string)
  default     = {}
}
