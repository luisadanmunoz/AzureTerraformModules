################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "Dashboard"
  }

  tags = merge(local.default_tags, var.tags)
}
