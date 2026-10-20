#############################################################################
# VARIABLES NETAPP ACCOUNT
#############################################################################
variable "netapp_account_name" {
  description = "value to set the netapp account name"
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

variable "active_directory" {
  description = "value to set the active directory"
  type = object({
    dns_servers                       = list(string)
    domain                            = string
    smb_server_name                   = string
    username                          = string
    password                          = string
    aes_encryption_enabled            = optional(bool)
    kerberos_ad_name                  = optional(string)
    kerberos_kdc_ip                   = optional(string)
    ldap_over_tls_enabled             = optional(bool)
    ldap_signing_enabled              = optional(bool)
    local_nfs_users_with_ldap_allowed = optional(bool)
    organizational_unit               = optional(string)
    server_root_ca_certificate        = optional(string)
    site_name                         = optional(string)
  })
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
