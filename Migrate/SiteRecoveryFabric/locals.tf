################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "SiteRecoveryFabric"
  }

  tags = merge(local.default_tags, var.tags)
}
