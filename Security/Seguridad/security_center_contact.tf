#############################################################################
# SECURITY CENTER CONTACTS
#############################################################################
module "security_center_contact" {
  source = "./modules/security_center_contact"

  for_each = var.security_center_contacts

  security_center_contact_name = each.value["security_center_contact_name"]
  email                        = each.value["email"]
  alert_notifications          = each.value["alert_notifications"]
  alerts_to_admins             = each.value["alerts_to_admins"]
  phone                        = try(each.value["phone"], null)
  timeouts                     = try(each.value["timeouts"], null)
}
