locals {
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "GalleryImageVersion"
  }
  tags = merge(local.default_tags, var.tags)
}
