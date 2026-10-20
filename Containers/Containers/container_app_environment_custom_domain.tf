#############################################################################
# CONTAINER APP ENVIRONMENT CUSTOM DOMAINS
#############################################################################
module "container_app_environment_custom_domain" {
  source = "./modules/container_app_environment_custom_domain"

  for_each = var.container_app_environment_custom_domains

  container_app_environment_custom_domain_name = each.value["container_app_environment_custom_domain_name"]
  container_app_environment_id = try(
    element([for _, container_app_environment in module.container_app_environment : container_app_environment.id if container_app_environment.name == each.value["container_app_environment_name"]], 0),
    each.value["container_app_environment_id"]
  )
  certificate_blob_base64 = each.value["certificate_blob_base64"]
  certificate_password    = each.value["certificate_password"]
  dns_suffix              = each.value["dns_suffix"]
  timeouts                = try(each.value["timeouts"], null)
}
