################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Session Hosts."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Session Hosts should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name_prefix" {
  description = "(Optional) Prefix for the VM names. Default: 'vdsh'."
  type        = string
  default     = "vdsh"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "avd"
}

variable "environment" {
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

################################################################################
# Session Host Configuration
################################################################################

variable "instance_count" {
  description = "(Required) Number of Session Host VMs to create."
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 100
    error_message = "instance_count must be between 1 and 100."
  }
}

variable "vm_size" {
  description = "(Required) The SKU for the Session Host VMs."
  type        = string
  default     = "Standard_D4s_v5"
}

variable "admin_username" {
  description = "(Required) The admin username for the VMs."
  type        = string
  default     = "avdadmin"
}

variable "admin_password" {
  description = "(Optional) The admin password for the VMs. If not provided, a random password will be generated."
  type        = string
  default     = null
  sensitive   = true
}

variable "license_type" {
  description = "(Optional) License type for Windows. Values: Windows_Client, Windows_Server, None."
  type        = string
  default     = "Windows_Client"

  validation {
    condition     = contains(["Windows_Client", "Windows_Server", "None"], var.license_type)
    error_message = "license_type must be Windows_Client, Windows_Server, or None."
  }
}

variable "timezone" {
  description = "(Optional) The timezone for the VMs."
  type        = string
  default     = "UTC"
}

variable "secure_boot_enabled" {
  description = "(Optional) Enable Secure Boot for Trusted Launch. Default: true."
  type        = bool
  default     = true
}

variable "vtpm_enabled" {
  description = "(Optional) Enable vTPM for Trusted Launch. Default: true."
  type        = bool
  default     = true
}

variable "encryption_at_host_enabled" {
  description = "(Optional) Enable encryption at host. Default: false."
  type        = bool
  default     = false
}

################################################################################
# OS Image
################################################################################

variable "source_image_id" {
  description = "(Optional) The ID of the custom image or Azure Compute Gallery image. DEPENDENCY: Image must exist."
  type        = string
  default     = null
}

variable "source_image_reference" {
  description = <<-EOT
    (Optional) Source image reference from Azure Marketplace. Used if source_image_id is not provided.
    - publisher: Image publisher (e.g., MicrosoftWindowsDesktop)
    - offer: Image offer (e.g., windows-11)
    - sku: Image SKU (e.g., win11-23h2-avd)
    - version: Image version (e.g., latest)
  EOT
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-23h2-avd"
    version   = "latest"
  }
}

################################################################################
# OS Disk
################################################################################

variable "os_disk" {
  description = <<-EOT
    (Optional) OS disk configuration.
    - caching: Disk caching type. Default: ReadWrite.
    - storage_account_type: Disk type. Default: Premium_LRS.
    - disk_size_gb: Disk size in GB. Default: 128.
    - disk_encryption_set_id: ID of the disk encryption set.
  EOT
  type = object({
    caching                = optional(string, "ReadWrite")
    storage_account_type   = optional(string, "Premium_LRS")
    disk_size_gb           = optional(number, 128)
    disk_encryption_set_id = optional(string, null)
  })
  default = {}
}

################################################################################
# Networking
################################################################################

variable "subnet_id" {
  description = "(Required) The ID of the Subnet for the VMs. DEPENDENCY: Subnet must exist."
  type        = string
}

variable "enable_accelerated_networking" {
  description = "(Optional) Enable accelerated networking. Default: true."
  type        = bool
  default     = true
}

variable "private_ip_address_allocation" {
  description = "(Optional) IP allocation method. Values: Dynamic, Static. Default: Dynamic."
  type        = string
  default     = "Dynamic"
}

################################################################################
# Host Pool Registration
################################################################################

variable "hostpool_id" {
  description = "(Required) The ID of the AVD Host Pool. DEPENDENCY: Host Pool must exist."
  type        = string
}

variable "registration_token" {
  description = "(Required) The registration token from the Host Pool."
  type        = string
  sensitive   = true
}

################################################################################
# Domain Join
################################################################################

variable "domain_join_type" {
  description = "(Optional) Domain join type. Values: AzureAD, ActiveDirectory, None. Default: AzureAD."
  type        = string
  default     = "AzureAD"

  validation {
    condition     = contains(["AzureAD", "ActiveDirectory", "None"], var.domain_join_type)
    error_message = "domain_join_type must be AzureAD, ActiveDirectory, or None."
  }
}

variable "aad_join" {
  description = <<-EOT
    (Optional) Azure AD Join configuration. Required if domain_join_type is AzureAD.
    - intune_enrollment: Enable Intune enrollment. Default: false.
  EOT
  type = object({
    intune_enrollment = optional(bool, false)
  })
  default = {}
}

variable "ad_domain_join" {
  description = <<-EOT
    (Optional) Active Directory domain join configuration. Required if domain_join_type is ActiveDirectory.
    - domain_name: FQDN of the AD domain.
    - ou_path: OU path for computer objects.
    - domain_username: Domain admin username.
    - domain_password: Domain admin password.
  EOT
  type = object({
    domain_name     = string
    ou_path         = optional(string, null)
    domain_username = string
    domain_password = string
  })
  default   = null
  sensitive = true
}

################################################################################
# Identity
################################################################################

variable "identity_type" {
  description = "(Optional) Identity type. Values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned. Default: SystemAssigned."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "(Optional) List of User Assigned Identity IDs. DEPENDENCY: Identities must exist."
  type        = list(string)
  default     = []
}

################################################################################
# Availability
################################################################################

variable "availability_set_id" {
  description = "(Optional) The ID of an Availability Set. DEPENDENCY: Availability Set must exist."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "(Optional) The Availability Zone for the VMs. Values: 1, 2, 3, or null for no zone."
  type        = string
  default     = null
}

variable "zones_distribution" {
  description = "(Optional) Distribute VMs across zones. If true, ignores availability_zone."
  type        = bool
  default     = false
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
