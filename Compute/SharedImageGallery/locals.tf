locals {
  # Gallery names don't support hyphens
  generated_name = join("_", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "SharedImageGallery"
  }
  tags = merge(local.default_tags, var.tags)
}
