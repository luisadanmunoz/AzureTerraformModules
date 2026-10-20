################################################################################
# Local Values
################################################################################

locals {
  # Naming convention
  name_parts = compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance
  ])

  generated_name = lower(replace(join("-", local.name_parts), "_", "-"))
  policy_name    = var.name != null ? var.name : local.generated_name

  # Default tags
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "FirewallPolicy"
  }

  tags = merge(local.default_tags, var.tags)
}
