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
  cache_name     = var.name != null ? var.name : local.generated_name

  # Default tags
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "RedisCache"
  }

  tags = merge(local.default_tags, var.tags)

  # Determine if Premium features are available
  is_premium = contains(["Premium"], var.sku_name)
}
