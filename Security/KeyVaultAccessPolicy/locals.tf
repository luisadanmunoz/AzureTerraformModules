################################################################################
# Local Values
################################################################################

locals {
  # Key Vault Access Policies do not support tags directly.
  # This file is kept for module structure consistency.
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "KeyVaultAccessPolicy"
  }
}
