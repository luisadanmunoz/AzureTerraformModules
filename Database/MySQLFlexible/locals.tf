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

  generated_name = lower(join("-", local.name_parts))
  server_name    = var.name != null ? var.name : local.generated_name

  # Default tags
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "MySQLFlexible"
  }

  tags = merge(local.default_tags, var.tags)
}
