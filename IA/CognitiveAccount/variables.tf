################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the Cognitive Services account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
}

variable "kind" {
  description = "The kind of Cognitive Service. Possible values: AnomalyDetector, ComputerVision, ContentModerator, CustomVision.Prediction, CustomVision.Training, Face, FormRecognizer, ImmersiveReader, LUIS, Personalizer, SpeechServices, TextAnalytics, TextTranslation, CognitiveServices."
  type        = string
}

variable "sku_name" {
  description = "The SKU of the Cognitive Services account."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the account."
  type        = bool
  default     = true
}

################################################################################
# Optional - Network
################################################################################

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = true
}

variable "outbound_network_access_restricted" {
  description = "Whether outbound network access is restricted."
  type        = bool
  default     = false
}

variable "network_acls" {
  description = "Network ACLs for the account."
  type = object({
    default_action = string
    ip_rules       = optional(list(string), [])
    virtual_network_rules = optional(list(object({
      subnet_id                            = string
      ignore_missing_vnet_service_endpoint = optional(bool, false)
    })), [])
  })
  default = null
}

################################################################################
# Optional - Identity
################################################################################

variable "identity_type" {
  description = "The type of managed identity."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = []
}

################################################################################
# Optional - Other
################################################################################

variable "custom_subdomain_name" {
  description = "The custom subdomain name."
  type        = string
  default     = null
}

variable "local_auth_enabled" {
  description = "Whether local authentication is enabled."
  type        = bool
  default     = true
}

variable "custom_question_answering_search_service_id" {
  description = "The Search Service ID for QnA Maker."
  type        = string
  default     = null
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
