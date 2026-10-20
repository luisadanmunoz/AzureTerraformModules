#############################################################################
# IOT HUB ENRICHMENTS
#############################################################################
module "iothub_enrichment" {
  source = "./modules/iothub_enrichment"

  for_each = var.iothub_enrichments

  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_name = try(
    element([for _, iothub in module.iothub : iothub.name if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_name"]
  )
  key            = each.value["key"]
  value          = each.value["value"]
  endpoint_names = each.value["endpoint_names"]
  timeouts       = try(each.value["timeouts"], null)
}
