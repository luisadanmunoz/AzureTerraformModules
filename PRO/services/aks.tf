#############################################################################
# AKS
#############################################################################
module "aks" {
  source = "./module/aks"

  for_each = var.aks

  name                       = each.value["name"]
  location                   = each.value["location"]
  resource_group_name        = each.value["resource_group_name"]
  node_resource_group        = each.value["node_resource_group"]
  dns_prefix_private_cluster = each.value["dns_prefix_private_cluster"]
  private_dns_zone_id        = element([for k, v in module.private_dns_zone : v.id if v.name == each.value["private_dns_zone"]], 0)
  identity_ids               = toset([for k, v in module.assigned_identity : v.id if v.name == each.value["identity"]])
  vnet_subnet_id             = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)
  gateway_id                 = element([for k, v in module.application_gateway : v.id if v.name == each.value["application_gateway"]], 0)
  scope_dns                  = element([for k, v in module.private_dns_zone : v.id if v.name == each.value["private_dns_zone"]], 0)
  principal_id_identity      = element([for k, v in module.assigned_identity : v.principal_id if v.name == each.value["identity"]], 0)
  scope_rg                   = element([for k, v in module.resource_group : v.id if v.name == each.value["resource_group_name"]], 0)

}