################################################################################
# Local Values
################################################################################

locals {
  # Naming convention: prefix-workload-environment-instance
  # Example: anfpool-shared-dev-001
  generated_name = join("-", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance
  ]))

  # Use explicit name if provided, otherwise use generated name
  resource_name = var.name != null ? var.name : local.generated_name

  # Merge default tags with user-provided tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "NetAppPool"
  }

  tags = merge(local.default_tags, var.tags)
}
