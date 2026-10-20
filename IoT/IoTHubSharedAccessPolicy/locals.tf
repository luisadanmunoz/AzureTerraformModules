################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "IoTHubSharedAccessPolicy"
  }

  tags = merge(local.default_tags, var.tags)
}
