#############################################################################
# PRIVATE DNS A RECORD
#############################################################################
module "private_dns_a_record" {
  source = "./modules/private_dns_a_record"

  for_each = var.private_dns_a_record

  name                = each.value["name"]
  zone_name           = element([for k, v in module.private_dns_zone : v.name if v.name == each.value["zone_name"]], 0)
  resource_group_name = each.value["resource_group_name"]
  ttl                 = each.value["ttl"]
  records             = each.value["records"]

}