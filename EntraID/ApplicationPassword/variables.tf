################################################################################
# Required Variables
################################################################################

variable "application_id" {
  description = "The resource ID of the application for which this password should be created. Use either application_id or application_object_id."
  type        = string
  default     = null
}

variable "application_object_id" {
  description = "The object ID of the application for which this password should be created. Use either application_id or application_object_id."
  type        = string
  default     = null
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the application password."
  type        = bool
  default     = true
}

################################################################################
# Optional - Password Configuration
################################################################################

variable "display_name" {
  description = "A display name for the password. If not specified, a random name will be generated."
  type        = string
  default     = null
}

variable "end_date" {
  description = "The end date until which the password is valid, formatted as an RFC3339 date string (e.g. 2025-01-01T00:00:00Z). If not specified, defaults to 2 years from creation."
  type        = string
  default     = null
}

variable "end_date_relative" {
  description = "A relative duration for which the password is valid, for example 240h (10 days) or 2400h30m. Valid time units are ns, us, ms, s, m, h."
  type        = string
  default     = null
}

variable "start_date" {
  description = "The start date from which the password is valid, formatted as an RFC3339 date string (e.g. 2024-01-01T00:00:00Z). If not specified, the current date is used."
  type        = string
  default     = null
}

variable "rotate_when_changed" {
  description = "A map of values that, when changed, will trigger rotation of the password."
  type        = map(string)
  default     = null
}
