################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Automation Certificates."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "automation_account_name" {
  description = "(Required) The name of the Automation Account where the Certificates will be stored. DEPENDENCY: Automation Account must exist."
  type        = string
}

################################################################################
# Certificates
################################################################################

variable "certificates" {
  description = <<-EOT
    (Optional) Map of certificates to create. The key is the certificate name.
    - base64: (Required) The base64-encoded content of the PFX certificate.
    - password: (Optional) The password for the PFX certificate. Sensitive.
    - description: (Optional) Description of the certificate.
    - exportable: (Optional) Whether the certificate is exportable. Default: true.
  EOT
  type = map(object({
    base64      = string
    password    = optional(string, null)
    description = optional(string, null)
    exportable  = optional(bool, true)
  }))
  default   = {}
  sensitive = true
}
