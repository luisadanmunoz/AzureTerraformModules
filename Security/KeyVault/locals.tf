################################################################################
# Local Values
################################################################################

locals {
  # Naming convention - Key Vault names must be 3-24 chars, alphanumeric and hyphens
  name_parts = compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance
  ])

  generated_name = lower(replace(join("-", local.name_parts), "_", "-"))
  vault_name     = var.name != null ? var.name : local.generated_name

  # Default tags
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "KeyVault"
  }

  tags = merge(local.default_tags, var.tags)
}
