################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "ActionGroup"
  }

  tags = merge(local.default_tags, var.tags)
}
