#############################################################################
# VIRTUAL DESKTOP HOST POOL REGISTRATION INFOS
#############################################################################
module "virtual_desktop_host_pool_registration_info" {
  source = "./modules/virtual_desktop_host_pool_registration_info"

  for_each = var.virtual_desktop_host_pool_registration_infos

  hostpool_id = try(
    element([for _, host_pool in module.virtual_desktop_host_pool : host_pool.id if host_pool.name == each.value["virtual_desktop_host_pool_name"]], 0),
    each.value["hostpool_id"]
  )
  expiration_date = each.value["expiration_date"]
  timeouts        = try(each.value["timeouts"], null)
}
