#############################################################################
# RESOURCE PROVIDER REGISTRATIONS
#############################################################################
module "resource_provider_registration" {
  source = "./modules/resource_provider_registration"

  for_each = var.resource_provider_registrations

  resource_provider_name = each.value["resource_provider_name"]
}
