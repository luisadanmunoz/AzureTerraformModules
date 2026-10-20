#############################################################################
# CONTAINER APP CUSTOM DOMAINS
#############################################################################
module "container_app_custom_domain" {
  source = "./modules/container_app_custom_domain"

  for_each = var.container_app_custom_domains

  container_app_custom_domain_name = each.value["container_app_custom_domain_name"]
  container_app_id = try(
    element([for _, container_app in module.container_app : container_app.id if container_app.name == each.value["container_app_name"]], 0),
    each.value["container_app_id"]
  )
  container_app_environment_certificate_id = try(
    element([for _, container_app_environment_certificate in module.container_app_environment_certificate : container_app_environment_certificate.id if container_app_environment_certificate.name == each.value["container_app_environment_certificate_name"]], 0),
    each.value["container_app_environment_certificate_id"],
    null
  )
  certificate_binding_type = try(each.value["certificate_binding_type"], null)
  timeouts                 = try(each.value["timeouts"], null)
}
