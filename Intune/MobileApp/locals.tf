################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "MobileApp"
  }

  tags = merge(local.default_tags, var.tags)
}
