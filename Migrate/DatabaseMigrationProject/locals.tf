################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "DatabaseMigrationProject"
  }

  tags = merge(local.default_tags, var.tags)
}
