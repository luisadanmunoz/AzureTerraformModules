################################################################################
# Required Variables
################################################################################

variable "server_id" {
  description = "The ID of the SQL Server on which to create the elastic pool."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where the elastic pool will be created."
  type        = string
}

################################################################################
# Optional Variables - Naming
################################################################################

variable "name" {
  description = "The name of the elastic pool. If not provided, will be generated from naming variables."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix for the elastic pool name."
  type        = string
  default     = "sqlep"
}

variable "workload" {
  description = "The workload name for naming convention."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment name (dev, staging, prod) for naming convention."
  type        = string
  default     = ""
}

variable "instance" {
  description = "The instance identifier for naming convention."
  type        = string
  default     = "001"
}

################################################################################
# Optional Variables - Configuration
################################################################################

variable "create" {
  description = "Controls whether resources should be created."
  type        = bool
  default     = true
}

variable "license_type" {
  description = "The license type for the elastic pool. Valid values are LicenseIncluded or BasePrice."
  type        = string
  default     = "LicenseIncluded"

  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = "License type must be LicenseIncluded or BasePrice."
  }
}

variable "max_size_gb" {
  description = "The maximum size of the elastic pool in gigabytes."
  type        = number
  default     = null
}

variable "zone_redundant" {
  description = "Whether the elastic pool is zone redundant. Only for Premium and Business Critical tiers."
  type        = bool
  default     = false
}

variable "maintenance_configuration_name" {
  description = "The name of the maintenance configuration. Examples: SQL_Default, SQL_WestEurope_DB_1."
  type        = string
  default     = "SQL_Default"
}

variable "enclave_type" {
  description = "The type of enclave for the elastic pool. Valid values are Default or VBS."
  type        = string
  default     = null
}

################################################################################
# Optional Variables - SKU
################################################################################

variable "sku" {
  description = "SKU configuration for the elastic pool."
  type = object({
    name     = string
    tier     = string
    family   = optional(string)
    capacity = number
  })
  default = {
    name     = "GP_Gen5"
    tier     = "GeneralPurpose"
    family   = "Gen5"
    capacity = 2
  }

  validation {
    condition     = contains(["BasicPool", "StandardPool", "PremiumPool", "GP_Gen5", "GP_Fsv2", "GP_DC", "BC_Gen5", "BC_DC", "HS_Gen5"], var.sku.name)
    error_message = "SKU name must be a valid elastic pool SKU."
  }
}

################################################################################
# Optional Variables - Per-database Settings
################################################################################

variable "per_database_settings" {
  description = "Per-database settings for the elastic pool."
  type = object({
    min_capacity = number
    max_capacity = number
  })
  default = {
    min_capacity = 0
    max_capacity = 2
  }
}

################################################################################
# Optional Variables - Tags
################################################################################

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
