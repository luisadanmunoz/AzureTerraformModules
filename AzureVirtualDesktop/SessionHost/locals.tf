################################################################################
# Local Values
################################################################################

locals {
  # Naming
  base_name = join("-", compact([var.name_prefix, var.workload, var.environment]))

  # Tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "AVDSessionHost"
  }
  tags = merge(local.default_tags, var.tags)

  # Domain join flags
  is_aad_join = var.domain_join_type == "AzureAD"
  is_ad_join  = var.domain_join_type == "ActiveDirectory"

  # Availability zones distribution
  zones = var.zones_distribution ? ["1", "2", "3"] : []

  # Use custom image or marketplace
  use_custom_image = var.source_image_id != null
}
