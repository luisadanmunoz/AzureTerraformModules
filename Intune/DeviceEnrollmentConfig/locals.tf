################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "DeviceEnrollmentConfig"
  }

  tags = merge(local.default_tags, var.tags)
}
