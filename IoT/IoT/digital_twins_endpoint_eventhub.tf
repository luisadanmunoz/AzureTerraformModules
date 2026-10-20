#############################################################################
# DIGITAL TWINS ENDPOINT EVENTHUBS
#############################################################################
module "digital_twins_endpoint_eventhub" {
  source = "./modules/digital_twins_endpoint_eventhub"

  for_each = var.digital_twins_endpoint_eventhubs

  digital_twins_endpoint_eventhub_name = each.value["digital_twins_endpoint_eventhub_name"]
  digital_twins_id = try(
    element([for _, digital_twins in module.digital_twins_instance : digital_twins.id if digital_twins.name == each.value["digital_twins_instance_name"]], 0),
    each.value["digital_twins_id"]
  )
  eventhub_primary_connection_string   = each.value["eventhub_primary_connection_string"]
  eventhub_secondary_connection_string = each.value["eventhub_secondary_connection_string"]
  dead_letter_storage_secret           = try(each.value["dead_letter_storage_secret"], null)
  timeouts                             = try(each.value["timeouts"], null)
}
