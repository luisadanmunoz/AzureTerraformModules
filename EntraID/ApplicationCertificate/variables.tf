################################################################################
# Required Variables
################################################################################

variable "application_id" {
  description = "The resource ID of the application for which this certificate should be created."
  type        = string
}

variable "value" {
  description = "The certificate data, which can be PEM encoded, base64 encoded DER, or hexadecimal encoded DER. See also the encoding argument."
  type        = string
  sensitive   = true
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the application certificate."
  type        = bool
  default     = true
}

################################################################################
# Optional - Certificate Configuration
################################################################################

variable "encoding" {
  description = "Specifies the encoding used for the supplied certificate data. Must be one of: pem, base64, or hex."
  type        = string
  default     = "pem"

  validation {
    condition     = contains(["pem", "base64", "hex"], var.encoding)
    error_message = "encoding must be one of: pem, base64, or hex."
  }
}

variable "key_id" {
  description = "A UUID used to uniquely identify this certificate. If not specified, a UUID will be automatically generated."
  type        = string
  default     = null
}

variable "start_date" {
  description = "The start date from which the certificate is valid, formatted as an RFC3339 date string (e.g. 2024-01-01T00:00:00Z). If not specified, the current date is used."
  type        = string
  default     = null
}

variable "end_date" {
  description = "The end date until which the certificate is valid, formatted as an RFC3339 date string (e.g. 2025-01-01T00:00:00Z). If not specified, defaults to 2 years from the start date."
  type        = string
  default     = null
}

variable "end_date_relative" {
  description = "A relative duration for which the certificate is valid, for example 240h (10 days) or 2400h30m. Valid time units are ns, us, ms, s, m, h."
  type        = string
  default     = null
}

variable "type" {
  description = "The type of key/certificate. Must be one of: AsymmetricX509Cert or Symmetric. Changing this forces a new resource."
  type        = string
  default     = "AsymmetricX509Cert"

  validation {
    condition     = contains(["AsymmetricX509Cert", "Symmetric"], var.type)
    error_message = "type must be one of: AsymmetricX509Cert or Symmetric."
  }
}
