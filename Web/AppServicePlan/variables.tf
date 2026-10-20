# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

# DEPENDENCY: This module requires an existing Resource Group.
# Use the ResourceGroup module to create one if needed.
variable "resource_group_name" {
  description = "The name of the resource group where the App Service Plan will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the App Service Plan will be created."
  type        = string
}

# -----------------------------------------------------------------------------
# Naming Variables
# -----------------------------------------------------------------------------

variable "name" {
  description = "The exact name to use for the App Service Plan. If provided, overrides generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix to use for the generated App Service Plan name."
  type        = string
  default     = "asp"
}

variable "workload" {
  description = "The workload name to include in the generated name."
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name to include in the generated name (e.g., dev, staging, prod)."
  type        = string
  default     = null
}

variable "instance" {
  description = "The instance identifier to include in the generated name."
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# Tags
# -----------------------------------------------------------------------------

variable "tags" {
  description = "A map of tags to assign to the App Service Plan."
  type        = map(string)
  default     = {}
}

# -----------------------------------------------------------------------------
# App Service Plan Specific Variables
# -----------------------------------------------------------------------------

variable "os_type" {
  description = "The operating system type for the App Service Plan. Valid values are 'Linux', 'Windows', or 'WindowsContainer'."
  type        = string

  validation {
    condition     = contains(["Linux", "Windows", "WindowsContainer"], var.os_type)
    error_message = "The os_type must be one of: 'Linux', 'Windows', or 'WindowsContainer'."
  }
}

variable "sku_name" {
  description = "The SKU name for the App Service Plan. Common values include B1, B2, B3, S1, S2, S3, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, P0v3, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, F1, D1, Y1, EP1, EP2, EP3, WS1, WS2, WS3."
  type        = string

  validation {
    condition = contains([
      "B1", "B2", "B3",
      "S1", "S2", "S3",
      "P1v2", "P2v2", "P3v2",
      "P1v3", "P2v3", "P3v3", "P0v3",
      "I1", "I2", "I3",
      "I1v2", "I2v2", "I3v2", "I4v2", "I5v2", "I6v2",
      "F1", "D1",
      "Y1",
      "EP1", "EP2", "EP3",
      "WS1", "WS2", "WS3"
    ], var.sku_name)
    error_message = "The sku_name must be a valid App Service Plan SKU. Valid values: B1, B2, B3, S1, S2, S3, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, P0v3, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, F1, D1, Y1, EP1, EP2, EP3, WS1, WS2, WS3."
  }
}

variable "worker_count" {
  description = "The number of workers (instances) to be allocated. Defaults to null for automatic scaling."
  type        = number
  default     = null
}

variable "maximum_elastic_worker_count" {
  description = "The maximum number of workers to use in an Elastic SKU Plan. Only valid for Elastic Premium (EP) SKUs."
  type        = number
  default     = null
}

# DEPENDENCY: This variable requires an existing App Service Environment.
# Use the AppServiceEnvironment module to create one if needed.
variable "app_service_environment_id" {
  description = "The ID of the App Service Environment to deploy the App Service Plan to. Required for Isolated (I) tier SKUs."
  type        = string
  default     = null
}

variable "per_site_scaling_enabled" {
  description = "Whether per-site scaling is enabled for the App Service Plan. When enabled, apps can be scaled independently."
  type        = bool
  default     = false
}

variable "zone_balancing_enabled" {
  description = "Whether zone balancing is enabled for the App Service Plan. Requires Premium v2/v3 or Isolated v2 SKUs in a zone-redundant region."
  type        = bool
  default     = false
}
