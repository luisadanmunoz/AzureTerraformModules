################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "APIManagement"
  }

  tags = merge(local.default_tags, var.tags)
}
