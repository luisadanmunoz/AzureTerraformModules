################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "ArcPrivateLinkScope"
  }

  tags = merge(local.default_tags, var.tags)
}
