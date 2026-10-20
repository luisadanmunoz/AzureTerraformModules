#############################################################################
# SNOWFLAKE - PRIVATE ENDPOINT 
#############################################################################

module "private_endpoint" {
  source = "./modules/private_endpoint"

  for_each = var.private_endpoint

  custom_network_interface_name = each.value["custom_network_interface_name"]
  name                          = each.value["name"]
  location                      = each.value["location"]
  resource_group_name           = each.value["resource_group_name"]
  subnet_id                     = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)

  name_private_service_connection   = each.value["private_service"]
  private_connection_resource_id    = each.value["private_connection_resource_id"]
  subresource_names                 = each.value["subresource_names"]
  subresource                       = each.value["subresource"]
  alias                             = each.value["alias"]
  private_connection_resource_alias = each.value["private_connection_resource_alias"]
  id                                = each.value["id"]


}
