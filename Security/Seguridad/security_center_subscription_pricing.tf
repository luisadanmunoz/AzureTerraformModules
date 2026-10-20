#############################################################################
# SECURITY CENTER SUBSCRIPTION PRICINGS
#############################################################################
module "security_center_subscription_pricing" {
  source = "./modules/security_center_subscription_pricing"

  for_each = var.security_center_subscription_pricings

  tier          = each.value["tier"]
  resource_type = try(each.value["resource_type"], null)
  subplan       = try(each.value["subplan"], null)
  extensions    = coalesce(try(each.value["extensions"], null), [])
  timeouts      = try(each.value["timeouts"], null)
}
