################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Action Group."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "short_name" {
  description = "The short name of the Action Group (max 12 characters)."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the Action Group."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "enabled" {
  description = "Whether the Action Group is enabled."
  type        = bool
  default     = true
}

variable "email_receivers" {
  description = "List of email receivers."
  type = list(object({
    name                    = string
    email_address           = string
    use_common_alert_schema = optional(bool, true)
  }))
  default = []
}

variable "sms_receivers" {
  description = "List of SMS receivers."
  type = list(object({
    name         = string
    country_code = string
    phone_number = string
  }))
  default = []
}

variable "webhook_receivers" {
  description = "List of webhook receivers."
  type = list(object({
    name                    = string
    service_uri             = string
    use_common_alert_schema = optional(bool, true)
  }))
  default = []
}

variable "azure_app_push_receivers" {
  description = "List of Azure app push notification receivers."
  type = list(object({
    name          = string
    email_address = string
  }))
  default = []
}

variable "logic_app_receivers" {
  description = "List of Logic App receivers."
  type = list(object({
    name                    = string
    resource_id             = string
    callback_url            = string
    use_common_alert_schema = optional(bool, true)
  }))
  default = []
}

variable "azure_function_receivers" {
  description = "List of Azure Function receivers."
  type = list(object({
    name                     = string
    function_app_resource_id = string
    function_name            = string
    http_trigger_url         = string
    use_common_alert_schema  = optional(bool, true)
  }))
  default = []
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
