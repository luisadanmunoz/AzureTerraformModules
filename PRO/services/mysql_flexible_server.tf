#############################################################################
# MYSQL FLEXIBLE SERVER
#############################################################################
module "mysql_flexible_server" {
  source = "./modules/mysql_flexible_server"

  for_each = var.mysql_flexible_server

  secret_name = each.value["secret_name"]
  keyvault_id = element([for k, v in module.keyvault : v.id if k == each.value["location"]], 0)

  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]
  administrator_login = each.value["administrator_login"]
  #administrator_password = each.value["administrator_password"]
  backup_retention_days = each.value["backup_retention_days"]
  #delegated_subnet_id    = element([for k, v in module.subnet_delegation : v.id if v.name == each.value["delegated_subnet"]], 0)
  #private_dns_zone_id    = element([for k, v in module.private_dns_zone : v.id if v.name == each.value["private_zone_dns"]], 0)
  sku_name = each.value["sku_name"]

  zone               = each.value["zone"]
  subnet_id          = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)
  private_ip_address = each.value["private_ip_address"]
  subresource_name   = each.value["subresource_name"]
  member_name        = each.value["member_name"]
  #public_network_access_enabled = each.value["public_network_access_enabled"]


  depends_on = [module.rg]
}