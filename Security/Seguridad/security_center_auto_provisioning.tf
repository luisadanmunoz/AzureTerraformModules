#############################################################################
# SECURITY CENTER AUTO PROVISIONINGS
#############################################################################
module "security_center_auto_provisioning" {
  source = "./modules/security_center_auto_provisioning"

  for_each = var.security_center_auto_provisionings

  auto_provision = each.value["auto_provision"]
  timeouts       = try(each.value["timeouts"], null)
}
