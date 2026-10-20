################################################################################
# Required Variables
################################################################################

variable "name" {
  description = "The name of the deployment."
  type        = string
}

variable "cognitive_account_id" {
  description = "The ID of the Cognitive Services (OpenAI) account."
  type        = string
}

variable "model_name" {
  description = "The name of the model to deploy (e.g., gpt-4, gpt-35-turbo)."
  type        = string
}

variable "model_version" {
  description = "The version of the model to deploy."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the deployment."
  type        = bool
  default     = true
}

################################################################################
# Optional - Model Configuration
################################################################################

variable "model_format" {
  description = "The format of the model. Default is OpenAI."
  type        = string
  default     = "OpenAI"
}

variable "version_upgrade_option" {
  description = "Deployment version upgrade option. Possible values: OnceNewDefaultVersionAvailable, OnceCurrentVersionExpired, NoAutoUpgrade."
  type        = string
  default     = "OnceNewDefaultVersionAvailable"
}

################################################################################
# Optional - Scale Settings
################################################################################

variable "scale_type" {
  description = "The scale type. Possible values: Standard, Manual."
  type        = string
  default     = "Standard"
}

variable "scale_tier" {
  description = "The scale tier for Standard deployments."
  type        = string
  default     = null
}

variable "scale_size" {
  description = "The scale size for Standard deployments."
  type        = string
  default     = null
}

variable "scale_family" {
  description = "The scale family for Standard deployments."
  type        = string
  default     = null
}

variable "scale_capacity" {
  description = "The capacity (TPM in thousands) for the deployment."
  type        = number
  default     = 1
}

################################################################################
# Optional - RAI Policy
################################################################################

variable "rai_policy_name" {
  description = "The name of the RAI (Responsible AI) policy to apply."
  type        = string
  default     = null
}
