################################################################################
# Local Values
################################################################################

locals {
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  policy_name    = var.name != null ? var.name : local.generated_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "FirewallPolicy"
  }
  tags = merge(local.default_tags, var.tags)
}
