#############################################################################
# IOT HUB DPS CERTIFICATES
#############################################################################
module "iothub_dps_certificate" {
  source = "./modules/iothub_dps_certificate"

  for_each = var.iothub_dps_certificates

  iothub_dps_certificate_name = each.value["iothub_dps_certificate_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_dps_name = try(
    element([for _, iothub_dps in module.iothub_dps : iothub_dps.name if iothub_dps.name == each.value["iothub_dps_name"]], 0),
    each.value["iothub_dps_name"]
  )
  certificate_content = each.value["certificate_content"]
  is_verified         = try(each.value["is_verified"], null)
  timeouts            = try(each.value["timeouts"], null)
}
