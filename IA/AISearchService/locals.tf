################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "AISearchService"
  }

  tags = merge(local.default_tags, var.tags)
}
