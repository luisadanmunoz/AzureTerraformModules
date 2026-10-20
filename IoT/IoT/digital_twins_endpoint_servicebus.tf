#############################################################################
# DIGITAL TWINS ENDPOINT SERVICEBUSES
#############################################################################
module "digital_twins_endpoint_servicebus" {
  source = "./modules/digital_twins_endpoint_servicebus"

  for_each = var.digital_twins_endpoint_servicebuses

  digital_twins_endpoint_servicebus_name = each.value["digital_twins_endpoint_servicebus_name"]
  digital_twins_id = try(
    element([for _, digital_twins in module.digital_twins_instance : digital_twins.id if digital_twins.name == each.value["digital_twins_instance_name"]], 0),
    each.value["digital_twins_id"]
  )
  servicebus_primary_connection_string   = each.value["servicebus_primary_connection_string"]
  servicebus_secondary_connection_string = each.value["servicebus_secondary_connection_string"]
  dead_letter_storage_secret             = try(each.value["dead_letter_storage_secret"], null)
  timeouts                               = try(each.value["timeouts"], null)
}
