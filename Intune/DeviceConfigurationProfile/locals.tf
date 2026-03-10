################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "DeviceConfigurationProfile"
  }

  tags = merge(local.default_tags, var.tags)
}
