#############################################################################
# DIGITAL TWINS ENDPOINT EVENTGRIDS
#############################################################################
module "digital_twins_endpoint_eventgrid" {
  source = "./modules/digital_twins_endpoint_eventgrid"

  for_each = var.digital_twins_endpoint_eventgrids

  digital_twins_endpoint_eventgrid_name = each.value["digital_twins_endpoint_eventgrid_name"]
  digital_twins_id = try(
    element([for _, digital_twins in module.digital_twins_instance : digital_twins.id if digital_twins.name == each.value["digital_twins_instance_name"]], 0),
    each.value["digital_twins_id"]
  )
  eventgrid_topic_endpoint             = each.value["eventgrid_topic_endpoint"]
  eventgrid_topic_primary_access_key   = each.value["eventgrid_topic_primary_access_key"]
  eventgrid_topic_secondary_access_key = each.value["eventgrid_topic_secondary_access_key"]
  dead_letter_storage_secret           = try(each.value["dead_letter_storage_secret"], null)
  timeouts                             = try(each.value["timeouts"], null)
}
