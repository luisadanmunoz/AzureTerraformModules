################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "RelayNamespace"
  }

  tags = merge(local.default_tags, var.tags)
}
