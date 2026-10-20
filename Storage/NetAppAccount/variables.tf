# -----------------------------------------------------------------------------
# REQUIRED PARAMETERS
# -----------------------------------------------------------------------------

variable "resource_group_name" {
  description = "The name of the resource group in which to create the NetApp Account."
  type        = string
  # DEPENDENCY: Resource group must exist before creating the NetApp Account
}

variable "location" {
  description = "The Azure region where the NetApp Account will be created."
  type        = string
}

# -----------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# -----------------------------------------------------------------------------

variable "create" {
  description = "Controls whether the NetApp Account should be created."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the NetApp Account. If provided, overrides the generated name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix to use for the generated NetApp Account name."
  type        = string
  default     = "anf"
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

variable "tags" {
  description = "A mapping of tags to assign to the NetApp Account."
  type        = map(string)
  default     = {}
}

variable "active_directory" {
  description = <<-EOT
    Active Directory configuration for the NetApp Account. Required for SMB volumes.
    - dns_servers: List of DNS server IP addresses for Active Directory domain resolution.
    - domain: The Active Directory domain name.
    - username: The username of the Active Directory domain administrator.
    - password: The password of the Active Directory domain administrator.
    - smb_server_name: The NetBIOS name of the SMB server.
    - organizational_unit: The Organizational Unit (OU) path in Active Directory.
    - kerberos_ad_name: Name of the Active Directory machine account for Kerberos.
    - kerberos_kdc_ip: IP address of the Kerberos Key Distribution Center.
    - aes_encryption_enabled: Specifies whether AES encryption is enabled for SMB.
    - local_nfs_users_with_ldap_allowed: Allow local NFS users with LDAP.
    - ldap_over_tls_enabled: Specifies whether LDAP over TLS is enabled.
    - server_root_ca_certificate: Server root CA certificate for LDAP over TLS.
    - ldap_signing_enabled: Specifies whether LDAP signing is enabled.
  EOT
  type = object({
    dns_servers                       = list(string)
    domain                            = string
    username                          = string
    password                          = string
    smb_server_name                   = string
    organizational_unit               = optional(string)
    kerberos_ad_name                  = optional(string)
    kerberos_kdc_ip                   = optional(string)
    aes_encryption_enabled            = optional(bool)
    local_nfs_users_with_ldap_allowed = optional(bool)
    ldap_over_tls_enabled             = optional(bool)
    server_root_ca_certificate        = optional(string)
    ldap_signing_enabled              = optional(bool)
  })
  default   = null
  sensitive = true
  # DEPENDENCY: Active Directory domain must be accessible from the virtual network
}

variable "identity" {
  description = <<-EOT
    Identity configuration for the NetApp Account.
    - type: The identity type. Possible values are SystemAssigned and UserAssigned.
    - identity_ids: List of User Assigned Identity IDs to assign to the NetApp Account.
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
  # DEPENDENCY: User Assigned Identities must exist before being assigned
}
