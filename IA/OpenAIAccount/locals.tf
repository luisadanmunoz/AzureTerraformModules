################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "OpenAIAccount"
  }

  tags = merge(local.default_tags, var.tags)
}
