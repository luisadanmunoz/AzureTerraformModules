# #############################################################################
# # STORAGE ACCOUNT
# #############################################################################
module "sta" {
  source = "./modules/sta"

  for_each = var.sta

  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]
  # #############################################################################
  # # STORAGE ACCOUNT - CONTAINER
  # #############################################################################
  container = each.value["container"]
  # #############################################################################
  # # STORAGE ACCOUNT - PRIVATE ENDPOINT
  # #############################################################################
  subnet_id = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)

  tags = var.tags

  depends_on = [module.subnet, module.private_dns_zone]
}