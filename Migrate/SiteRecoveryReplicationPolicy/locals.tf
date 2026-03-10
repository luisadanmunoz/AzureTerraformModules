################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "SiteRecoveryReplicationPolicy"
  }

  tags = merge(local.default_tags, var.tags)
}
