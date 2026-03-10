################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Automation Account."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Automation Account should exist. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Automation Account should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the Automation Account. If not provided, a name will be generated using the naming convention."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'aa'."
  type        = string
  default     = "aa"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "automation"
}

variable "environment" {
  description = "(Optional) Environment name for the naming convention (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number for the naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Automation Account Configuration
################################################################################

variable "sku_name" {
  description = "(Optional) The SKU of the Automation Account. Possible values: Free, Basic. Default: Basic."
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Free", "Basic"], var.sku_name)
    error_message = "sku_name must be one of: Free, Basic."
  }
}

variable "local_authentication_enabled" {
  description = "(Optional) Whether local authentication methods are enabled. Default: true."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether public network access is allowed. Default: true."
  type        = bool
  default     = true
}

################################################################################
# Identity
################################################################################

variable "identity" {
  description = <<-EOT
    (Optional) Identity configuration for the Automation Account.
    - type: (Required) Type of identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.
    - identity_ids: (Optional) List of User Assigned Identity IDs. Required when type contains UserAssigned. DEPENDENCY: User Assigned Identities must exist.
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "identity.type must be one of: SystemAssigned, UserAssigned, 'SystemAssigned, UserAssigned'."
  }
}

################################################################################
# Encryption (Customer Managed Key)
################################################################################

variable "encryption" {
  description = <<-EOT
    (Optional) Encryption configuration using Customer Managed Keys.
    - key_vault_key_id: (Required) The ID of the Key Vault Key. DEPENDENCY: Key Vault Key must exist.
    - user_assigned_identity_id: (Optional) The User Assigned Identity ID for accessing the Key Vault. DEPENDENCY: User Assigned Identity must exist and have access to Key Vault.
  EOT
  type = object({
    key_vault_key_id           = string
    user_assigned_identity_id  = optional(string, null)
  })
  default = null
}

################################################################################
# Private Endpoints
################################################################################

variable "private_endpoints" {
  description = <<-EOT
    (Optional) List of Private Endpoints to create for the Automation Account.
    - name: (Required) Name of the Private Endpoint.
    - subnet_id: (Required) The ID of the Subnet where the Private Endpoint will be created. DEPENDENCY: Subnet must exist.
    - subresource_names: (Required) List of subresources to connect. Values: Webhook, DSCAndHybridWorker.
    - private_dns_zone_ids: (Optional) List of Private DNS Zone IDs. DEPENDENCY: Private DNS Zones must exist.
    - is_manual_connection: (Optional) Manual approval required. Default: false.
  EOT
  type = list(object({
    name                 = string
    subnet_id            = string
    subresource_names    = list(string)
    private_dns_zone_ids = optional(list(string), [])
    is_manual_connection = optional(bool, false)
  }))
  default = []
}

################################################################################
# Diagnostic Settings
################################################################################

variable "diagnostic_settings" {
  description = <<-EOT
    (Optional) Diagnostic settings for the Automation Account.
    - name: (Required) Name of the diagnostic setting.
    - log_analytics_workspace_id: (Optional) Log Analytics Workspace ID. DEPENDENCY: Log Analytics must exist.
    - storage_account_id: (Optional) Storage Account ID for archiving. DEPENDENCY: Storage Account must exist.
    - eventhub_authorization_rule_id: (Optional) Event Hub authorization rule ID. DEPENDENCY: Event Hub must exist.
    - eventhub_name: (Optional) Event Hub name.
    - enabled_log_categories: (Optional) List of log categories to enable.
    - metric_categories: (Optional) List of metric categories to enable.
  EOT
  type = object({
    name                           = string
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    eventhub_name                  = optional(string, null)
    enabled_log_categories         = optional(list(string), ["JobLogs", "JobStreams", "DscNodeStatus", "AuditEvent"])
    metric_categories              = optional(list(string), ["AllMetrics"])
  })
  default = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
