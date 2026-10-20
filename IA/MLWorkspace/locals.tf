################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "MLWorkspace"
  }

  tags = merge(local.default_tags, var.tags)
}
