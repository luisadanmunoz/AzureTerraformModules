################################################################################
# Local Values
################################################################################

locals {
  # Naming - Remove hyphens for ACR (alphanumeric only)
  workload_clean    = replace(var.workload, "-", "")
  environment_clean = replace(var.environment, "-", "")
  instance_clean    = replace(var.instance, "-", "")
  prefix_clean      = replace(var.name_prefix, "-", "")

  name = var.name != null ? var.name : "${local.prefix_clean}${local.workload_clean}${local.environment_clean}${local.instance_clean}"

  # SKU capabilities
  is_premium = var.sku == "Premium"

  # Default tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "ACR"
  }
  tags = merge(local.default_tags, var.tags)
}
