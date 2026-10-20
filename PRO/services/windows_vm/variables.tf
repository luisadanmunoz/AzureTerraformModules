#############################################################################
# KEY VAULT SECRET
#############################################################################
variable "keyvault_id" {
  default = {}
}
#############################################################################
# WINDOWS VIRTUAL MACHINE
#############################################################################
variable "vm_name" {
  default = {}
}
variable "computer_name" {
  default = {}
}
variable "resource_group_name" {
  default = {}
}

variable "location" {
  default = {}
}

variable "size" {
  default = {}
}

variable "admin_username" {
  default = {}
}

variable "zone" {
  default = {}
}

variable "license_type" {
  default = {}
}

variable "caching" {
  default = {}
}

variable "storage_account_type" {
  default = {}
}

variable "publisher" {
  default = {}
}

variable "offer" {
  default = {}
}

variable "sku" {
  default = {}
}

variable "os_version" {
  default = {}
}

variable "tags" {
  default = {}
}
#############################################################################
# WINDOWS VIRTUAL MACHINE MODULE - NETWORK INTERFACE
#############################################################################
variable "subnet_id" {
  default = {}
}
variable "private_ip_address_allocation" {
  default = {}
}

variable "private_ip_address" {
  default = {}
}
/*
#############################################################################
# WINDOWS VIRTUAL MACHINE MODULE - MANAGED DISK
#############################################################################
variable "create_option" {
  default = {}
}

variable "disk_size_gb" {
  default = {}
}

variable "tier" {
  default = {}
}

#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
variable "name_diagnostic_setting" {
  default = {}
}
variable "workspace_resource_id" {
  default = {}
}
*/