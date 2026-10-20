################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name for the user."
  type        = string
}

variable "user_principal_name" {
  description = "The user principal name (UPN) in the format user@domain.com."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the user."
  type        = bool
  default     = true
}

################################################################################
# Optional - User Configuration
################################################################################

variable "account_enabled" {
  description = "Whether the account is enabled."
  type        = bool
  default     = true
}

variable "password" {
  description = "The initial password for the user."
  type        = string
  default     = null
  sensitive   = true
}

variable "force_password_change" {
  description = "Whether to force password change on first login."
  type        = bool
  default     = true
}

variable "mail" {
  description = "The primary email address of the user."
  type        = string
  default     = null
}

variable "mail_nickname" {
  description = "The mail alias for the user."
  type        = string
  default     = null
}

variable "given_name" {
  description = "The given name (first name) of the user."
  type        = string
  default     = null
}

variable "surname" {
  description = "The surname (family name) of the user."
  type        = string
  default     = null
}

variable "job_title" {
  description = "The job title of the user."
  type        = string
  default     = null
}

variable "department" {
  description = "The department in which the user works."
  type        = string
  default     = null
}

variable "company_name" {
  description = "The company name of the user."
  type        = string
  default     = null
}

variable "office_location" {
  description = "The office location of the user."
  type        = string
  default     = null
}

variable "usage_location" {
  description = "The usage location (two-letter country code) for license assignment."
  type        = string
  default     = null
}

variable "mobile_phone" {
  description = "The mobile phone number of the user."
  type        = string
  default     = null
}

variable "business_phones" {
  description = "A list of business phone numbers for the user."
  type        = list(string)
  default     = []
}

variable "street_address" {
  description = "The street address of the user."
  type        = string
  default     = null
}

variable "city" {
  description = "The city of the user."
  type        = string
  default     = null
}

variable "state" {
  description = "The state or province of the user."
  type        = string
  default     = null
}

variable "postal_code" {
  description = "The postal code of the user."
  type        = string
  default     = null
}

variable "country" {
  description = "The country of the user."
  type        = string
  default     = null
}

variable "employee_id" {
  description = "The employee identifier assigned by the organization."
  type        = string
  default     = null
}

variable "employee_type" {
  description = "The type of employee (e.g., Employee, Contractor)."
  type        = string
  default     = null
}

variable "manager_id" {
  description = "The object ID of the user's manager."
  type        = string
  default     = null
}

variable "show_in_address_list" {
  description = "Whether to show the user in the global address list."
  type        = bool
  default     = true
}

variable "disable_password_expiration" {
  description = "Whether to disable password expiration."
  type        = bool
  default     = false
}

variable "disable_strong_password" {
  description = "Whether to disable strong password requirement."
  type        = bool
  default     = false
}
