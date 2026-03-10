################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "IoTHub"
  }

  tags = merge(local.default_tags, var.tags)
}
