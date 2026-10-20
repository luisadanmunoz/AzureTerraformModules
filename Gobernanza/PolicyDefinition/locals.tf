################################################################################
# Local Values
################################################################################

locals {
  # Determine if we're creating at management group or subscription level
  is_management_group_scope = var.management_group_id != null

  # Load policy rule from file if specified
  policy_rule = var.policy_rule_file != null ? file(var.policy_rule_file) : var.policy_rule
}
