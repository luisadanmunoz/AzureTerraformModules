################################################################################
# Local Values
################################################################################

locals {
  # Determine if we're creating at management group or subscription level
  is_management_group_scope = var.management_group_id != null
}
