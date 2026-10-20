#############################################################################
# SECURITY CENTER SETTINGS
#############################################################################
module "security_center_setting" {
  source = "./modules/security_center_setting"

  for_each = var.security_center_settings

  setting_name = each.value["setting_name"]
  enabled      = each.value["enabled"]
  timeouts     = try(each.value["timeouts"], null)
}
