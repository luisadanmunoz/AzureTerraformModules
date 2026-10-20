#############################################################################
# IOTHUB
#############################################################################

module "iothub" {
  source = "./modules/iothub"

  for_each = var.iothub

  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]

  connection_string_sta = element([for k, v in module.sta : v.id if v.name == each.value["sta"]], 0)
  container_name        = each.value["container"]
  connection_string     = element([for k, v in module.eventhub : v.id if v.name == each.value["eventhub"]], 0)

  tags = var.tags

  #############################################################################
  # IOTHUB - PRIVATE ENDPOINT
  #############################################################################

  subnet_id            = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)
  private_dns_zone_ids = compact([for k, v in module.private_dns_zone : v.id if v.name == each.value["private_dns_zone_ids01"] || v.name == each.value["private_dns_zone_ids02"]])


  #############################################################################
  # IOTHUB - DEVICE UPDATE INSTANCE
  ############################################################################# 

  connection_string_diag = element([for k, v in module.sta : v.id if v.name == each.value["sta"]], 0)
  sta_id                 = element([for k, v in module.sta : v.id_sta if v.name == each.value["sta"]], 0)

}
