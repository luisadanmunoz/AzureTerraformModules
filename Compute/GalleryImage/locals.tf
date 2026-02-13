locals {
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "GalleryImage"
  }
  tags = merge(local.default_tags, var.tags)
}
