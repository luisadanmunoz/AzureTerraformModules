#############################################################################
# APPLICATION GATEWAY
#############################################################################
module "application_gateway" {
  source = "./modules/application_gateway"

  for_each = var.application_gateway

  name                 = each.value["name"]
  location             = each.value["location"]
  resource_group_name  = each.value["resource_group_name"]
  subnet_id            = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)
  public_ip_address_id = element([for k, v in module.public_ip : v.id if v.name == each.value["public_ip"]], 0)
  private_ip_address   = each.value["private_ip_address"]

}