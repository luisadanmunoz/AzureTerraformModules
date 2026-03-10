################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "AppProtectionPolicy"
  }

  tags = merge(local.default_tags, var.tags)
}
