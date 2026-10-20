################################################################################
# Local Values
################################################################################

locals {
  # Naming convention: prefix + workload + environment + instance + suffix
  # Azure Storage Table names do not support hyphens, so parts are concatenated
  # Example: tableshareddev001
  generated_name = join("", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance,
    var.name_suffix
  ]))

  # Use explicit name if provided, otherwise use generated name
  resource_name = var.name != null ? var.name : local.generated_name

  # Default tags applied to all resources created by this module
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "StorageTable"
  }

  # Merge default tags with user-provided tags (user tags take precedence)
  tags = merge(local.default_tags, var.tags)

  # Determine which mode to use: multiple tables (for_each) or single table (count)
  use_multiple_tables = length(var.tables) > 0
}
