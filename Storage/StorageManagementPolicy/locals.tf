################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "StorageManagementPolicy"
  }

  tags = merge(local.default_tags, var.tags)
}
