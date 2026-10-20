#############################################################################
# VARIABLES LINUX VIRTUAL MACHINE
#############################################################################
variable "linux_virtual_machine_name" {
  description = "value to set the linux virtual machine name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "size" {
  description = "value to set the size"
  type        = string
}

variable "network_interface_ids" {
  description = "value to set the network interface ids"
  type        = list(string)
}

variable "admin_username" {
  description = "value to set the admin username"
  type        = string
  default     = null
}

variable "admin_password" {
  description = "value to set the admin password"
  type        = string
  default     = null
  sensitive   = true
}

variable "allow_extension_operations" {
  description = "value to set the allow extension operations"
  type        = bool
  default     = null
}

variable "availability_set_id" {
  description = "value to set the availability set id"
  type        = string
  default     = null
}

variable "bypass_platform_safety_checks_on_user_schedule_enabled" {
  description = "value to set the bypass platform safety checks on user schedule enabled"
  type        = bool
  default     = null
}

variable "capacity_reservation_group_id" {
  description = "value to set the capacity reservation group id"
  type        = string
  default     = null
}

variable "computer_name" {
  description = "value to set the computer name"
  type        = string
  default     = null
}

variable "custom_data" {
  description = "value to set the custom data"
  type        = string
  default     = null
  sensitive   = true
}

variable "dedicated_host_group_id" {
  description = "value to set the dedicated host group id"
  type        = string
  default     = null
}

variable "dedicated_host_id" {
  description = "value to set the dedicated host id"
  type        = string
  default     = null
}

variable "disable_password_authentication" {
  description = "value to set the disable password authentication"
  type        = bool
  default     = null
}

variable "disk_controller_type" {
  description = "value to set the disk controller type"
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "value to set the edge zone"
  type        = string
  default     = null
}

variable "encryption_at_host_enabled" {
  description = "value to set the encryption at host enabled"
  type        = bool
  default     = null
}

variable "eviction_policy" {
  description = "value to set the eviction policy"
  type        = string
  default     = null
}

variable "extensions_time_budget" {
  description = "value to set the extensions time budget"
  type        = string
  default     = null
}

variable "license_type" {
  description = "value to set the license type"
  type        = string
  default     = null
}

variable "max_bid_price" {
  description = "value to set the max bid price"
  type        = number
  default     = null
}

variable "patch_assessment_mode" {
  description = "value to set the patch assessment mode"
  type        = string
  default     = null
}

variable "patch_mode" {
  description = "value to set the patch mode"
  type        = string
  default     = null
}

variable "platform_fault_domain" {
  description = "value to set the platform fault domain"
  type        = number
  default     = null
}

variable "priority" {
  description = "value to set the priority"
  type        = string
  default     = null
}

variable "provision_vm_agent" {
  description = "value to set the provision vm agent"
  type        = bool
  default     = null
}

variable "proximity_placement_group_id" {
  description = "value to set the proximity placement group id"
  type        = string
  default     = null
}

variable "reboot_setting" {
  description = "value to set the reboot setting"
  type        = string
  default     = null
}

variable "secure_boot_enabled" {
  description = "value to set the secure boot enabled"
  type        = bool
  default     = null
}

variable "source_image_id" {
  description = "value to set the source image id"
  type        = string
  default     = null
}

variable "user_data" {
  description = "value to set the user data"
  type        = string
  default     = null
}

variable "virtual_machine_scale_set_id" {
  description = "value to set the virtual machine scale set id"
  type        = string
  default     = null
}

variable "vtpm_enabled" {
  description = "value to set the vtpm enabled"
  type        = bool
  default     = null
}

variable "zone" {
  description = "value to set the zone"
  type        = string
  default     = null
}

variable "additional_capabilities" {
  description = "value to set the additional capabilities"
  type = object({
    hibernation_enabled = optional(bool)
    ultra_ssd_enabled   = optional(bool)
  })
  default = null
}

variable "admin_ssh_keys" {
  description = "value to set the admin ssh keys"
  type = list(object({
    username   = string
    public_key = string
  }))
  default = null
}

variable "boot_diagnostics" {
  description = "value to set the boot diagnostics"
  type = object({
    storage_account_uri = optional(string)
  })
  default = null
}

variable "gallery_applications" {
  description = "value to set the gallery applications"
  type = list(object({
    version_id                                  = string
    automatic_upgrade_enabled                   = optional(bool)
    configuration_blob_uri                      = optional(string)
    order                                       = optional(number)
    tag                                         = optional(string)
    treat_failure_as_deployment_failure_enabled = optional(bool)
  }))
  default = null
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "os_disk" {
  description = "value to set the os disk"
  type = object({
    caching                          = string
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    storage_account_type             = optional(string)
    write_accelerator_enabled        = optional(bool)
    diff_disk_settings = optional(object({
      option    = string
      placement = optional(string)
    }))
  })
}

variable "os_image_notification" {
  description = "value to set the os image notification"
  type = object({
    timeout = optional(string)
  })
  default = null
}

variable "plan" {
  description = "value to set the plan"
  type = object({
    name      = string
    product   = string
    publisher = string
  })
  default = null
}

variable "secrets" {
  description = "value to set the secrets"
  type = list(object({
    key_vault_id = string
    certificates = list(object({
      url = string
    }))
  }))
  default = null
}

variable "source_image_reference" {
  description = "value to set the source image reference"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = null
}

variable "termination_notification" {
  description = "value to set the termination notification"
  type = object({
    enabled = bool
    timeout = optional(string)
  })
  default = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
