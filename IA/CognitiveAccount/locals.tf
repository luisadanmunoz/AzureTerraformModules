################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "CognitiveAccount"
  }

  tags = merge(local.default_tags, var.tags)
}
