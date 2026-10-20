################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "PrivateDNSZone"
  }

  tags = merge(local.default_tags, var.tags)
}
