################################################################################
# Local Values
################################################################################

locals {
  # Naming convention: prefix-workload-environment-instance-suffix
  # Example: dlfs-analytics-dev-001
  generated_name = join("-", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance,
    var.name_suffix
  ]))

  # Use explicit name if provided, otherwise use generated name
  resource_name = var.name != null ? var.name : local.generated_name

  # Merge default tags with user-provided tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "DataLakeGen2"
  }

  tags = merge(local.default_tags, var.tags)
}
