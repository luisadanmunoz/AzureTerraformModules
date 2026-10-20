#############################################################################
# DIGITAL TWINS INSTANCES
#############################################################################
module "digital_twins_instance" {
  source = "./modules/digital_twins_instance"

  for_each = var.digital_twins_instances

  digital_twins_instance_name = each.value["digital_twins_instance_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location = each.value["location"]
  identity = try(each.value["identity"], null)
  timeouts = try(each.value["timeouts"], null)
  tags     = try(each.value["tags"], var.tags)
}
