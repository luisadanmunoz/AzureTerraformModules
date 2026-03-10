################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "KeyVaultSecret"
  }

  tags = merge(local.default_tags, var.tags)
}
