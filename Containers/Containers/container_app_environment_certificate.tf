#############################################################################
# CONTAINER APP ENVIRONMENT CERTIFICATES
#############################################################################
module "container_app_environment_certificate" {
  source = "./modules/container_app_environment_certificate"

  for_each = var.container_app_environment_certificates

  container_app_environment_certificate_name = each.value["container_app_environment_certificate_name"]
  container_app_environment_id = try(
    element([for _, container_app_environment in module.container_app_environment : container_app_environment.id if container_app_environment.name == each.value["container_app_environment_name"]], 0),
    each.value["container_app_environment_id"]
  )
  certificate_blob_base64 = try(each.value["certificate_blob_base64"], null)
  certificate_password    = try(each.value["certificate_password"], null)
  certificate_key_vault   = try(each.value["certificate_key_vault"], null)
  timeouts                = try(each.value["timeouts"], null)
  tags                    = try(each.value["tags"], var.tags)
}
