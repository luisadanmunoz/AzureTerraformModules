locals {
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "DNSZone"
  }
  tags = merge(local.default_tags, var.tags)
}
