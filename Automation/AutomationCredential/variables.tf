################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the Automation Credentials."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "automation_account_name" {
  description = "(Required) The name of the Automation Account where the Credentials will be created. DEPENDENCY: Automation Account must exist."
  type        = string
}

################################################################################
# Credentials
################################################################################

variable "credentials" {
  description = <<-EOT
    (Optional) Map of credentials to create. The key is the credential name.
    - username: (Required) The username for the credential.
    - password: (Required) The password for the credential. Sensitive value.
    - description: (Optional) Description of the credential.
  EOT
  type = map(object({
    username    = string
    password    = string
    description = optional(string, null)
  }))
  default   = {}
  sensitive = true
}
