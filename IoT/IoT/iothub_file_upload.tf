#############################################################################
# IOT HUB FILE UPLOADS
#############################################################################
module "iothub_file_upload" {
  source = "./modules/iothub_file_upload"

  for_each = var.iothub_file_uploads

  iothub_id = try(
    element([for _, iothub in module.iothub : iothub.id if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_id"]
  )
  connection_string     = each.value["connection_string"]
  container_name        = each.value["container_name"]
  authentication_type   = try(each.value["authentication_type"], null)
  identity_id           = try(each.value["identity_id"], null)
  default_ttl           = try(each.value["default_ttl"], null)
  lock_duration         = try(each.value["lock_duration"], null)
  max_delivery_count    = try(each.value["max_delivery_count"], null)
  notifications_enabled = try(each.value["notifications_enabled"], null)
  sas_ttl               = try(each.value["sas_ttl"], null)
  timeouts              = try(each.value["timeouts"], null)
}
