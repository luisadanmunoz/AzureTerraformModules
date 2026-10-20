################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "KeyVaultCertificate"
  }

  tags = merge(local.default_tags, var.tags)
}
