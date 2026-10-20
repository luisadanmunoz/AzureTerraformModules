locals {
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name
  dns_prefix     = var.dns_prefix != null ? var.dns_prefix : local.resource_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "AKS"
  }
  tags = merge(local.default_tags, var.tags)
}
