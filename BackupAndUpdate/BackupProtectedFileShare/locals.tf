locals {
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "BackupProtectedFileShare"
  }
  tags = merge(local.default_tags, var.tags)
}
