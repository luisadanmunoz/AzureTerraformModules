# -----------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# -----------------------------------------------------------------------------

variable "resource_group_name" {
  description = "The name of the resource group where the Application Insights will be created."
  type        = string

  # DEPENDENCY: Resource group must exist before creating Application Insights.
}

variable "location" {
  description = "The Azure region where the Application Insights will be created."
  type        = string
}

# -----------------------------------------------------------------------------
# OPTIONAL PARAMETERS - RESOURCE CREATION
# -----------------------------------------------------------------------------

variable "create" {
  description = "Controls whether the Application Insights resource should be created."
  type        = bool
  default     = true
}

# -----------------------------------------------------------------------------
# OPTIONAL PARAMETERS - NAMING
# -----------------------------------------------------------------------------

variable "name" {
  description = "The name of the Application Insights. If provided, overrides the generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The prefix for the Application Insights name. Used when generating the name."
  type        = string
  default     = "appi"
}

variable "workload" {
  description = "The workload name to use in the generated name."
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod) to use in the generated name."
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier to use in the generated name."
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# OPTIONAL PARAMETERS - TAGS
# -----------------------------------------------------------------------------

variable "tags" {
  description = "A map of tags to apply to the Application Insights resource."
  type        = map(string)
  default     = {}
}

# -----------------------------------------------------------------------------
# OPTIONAL PARAMETERS - APPLICATION INSIGHTS CONFIGURATION
# -----------------------------------------------------------------------------

variable "application_type" {
  description = "Specifies the type of Application Insights to create."
  type        = string
  default     = "web"

  validation {
    condition     = contains(["ios", "java", "MobileCenter", "Node.JS", "other", "phone", "store", "web"], var.application_type)
    error_message = "The application_type must be one of: ios, java, MobileCenter, Node.JS, other, phone, store, web."
  }
}

variable "workspace_id" {
  description = "The ID of the Log Analytics Workspace to associate with this Application Insights."
  type        = string
  default     = null

  # DEPENDENCY: Log Analytics workspace must exist. Recommended for workspace-based App Insights.
}

variable "daily_data_cap_in_gb" {
  description = "The daily data volume cap in GB. When set, data ingestion will be stopped once the cap is hit."
  type        = number
  default     = null
}

variable "daily_data_cap_notifications_disabled" {
  description = "Specifies if a notification email will be sent when the daily data volume cap is met."
  type        = bool
  default     = false
}

variable "retention_in_days" {
  description = "The number of days to retain data. Only applicable for classic Application Insights."
  type        = number
  default     = 90

  validation {
    condition     = contains([30, 60, 90, 120, 180, 270, 365, 550, 730], var.retention_in_days)
    error_message = "The retention_in_days must be one of: 30, 60, 90, 120, 180, 270, 365, 550, 730."
  }
}

variable "sampling_percentage" {
  description = "The percentage of telemetry items that will be sampled (0-100)."
  type        = number
  default     = null

  validation {
    condition     = var.sampling_percentage == null || (var.sampling_percentage >= 0 && var.sampling_percentage <= 100)
    error_message = "The sampling_percentage must be between 0 and 100."
  }
}

variable "disable_ip_masking" {
  description = "By default, the last octet of the IP address is masked to 0. Set to true to disable this behavior."
  type        = bool
  default     = false
}

variable "local_authentication_disabled" {
  description = "Disable local authentication to disable non-AAD based access to Application Insights."
  type        = bool
  default     = false
}

variable "internet_ingestion_enabled" {
  description = "Should the Application Insights component support ingestion over the public internet."
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = "Should the Application Insights component support querying over the public internet."
  type        = bool
  default     = true
}

variable "force_customer_storage_for_profiler" {
  description = "Should the Application Insights component force users to create their own storage account for profiling."
  type        = bool
  default     = false
}
