################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "SiteRecoveryProtectionContainer"
  }

  tags = merge(local.default_tags, var.tags)
}
