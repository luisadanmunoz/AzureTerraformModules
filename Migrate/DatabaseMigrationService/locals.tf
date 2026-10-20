################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "DatabaseMigrationService"
  }

  tags = merge(local.default_tags, var.tags)
}
