#############################################################################
# IOT HUB CERTIFICATES
#############################################################################
module "iothub_certificate" {
  source = "./modules/iothub_certificate"

  for_each = var.iothub_certificates

  iothub_certificate_name = each.value["iothub_certificate_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_name = try(
    element([for _, iothub in module.iothub : iothub.name if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_name"]
  )
  certificate_content = each.value["certificate_content"]
  is_verified         = try(each.value["is_verified"], null)
  timeouts            = try(each.value["timeouts"], null)
}
