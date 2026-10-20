#############################################################################
# MACHINE LEARNING WORKSPACES
#############################################################################
module "machine_learning_workspace" {
  source = "./modules/machine_learning_workspace"

  for_each = var.machine_learning_workspaces

  machine_learning_workspace_name = each.value["machine_learning_workspace_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                        = each.value["location"]
  application_insights_id         = each.value["application_insights_id"]
  key_vault_id                    = each.value["key_vault_id"]
  storage_account_id              = each.value["storage_account_id"]
  identity                        = each.value["identity"]
  container_registry_id           = try(each.value["container_registry_id"], null)
  description                     = try(each.value["description"], null)
  friendly_name                   = try(each.value["friendly_name"], null)
  high_business_impact            = try(each.value["high_business_impact"], null)
  image_build_compute_name        = try(each.value["image_build_compute_name"], null)
  kind                            = try(each.value["kind"], null)
  primary_user_assigned_identity  = try(each.value["primary_user_assigned_identity"], null)
  public_network_access_enabled   = try(each.value["public_network_access_enabled"], null)
  service_side_encryption_enabled = try(each.value["service_side_encryption_enabled"], null)
  sku_name                        = try(each.value["sku_name"], null)
  v1_legacy_mode_enabled          = try(each.value["v1_legacy_mode_enabled"], null)
  encryption                      = try(each.value["encryption"], null)
  feature_store                   = try(each.value["feature_store"], null)
  managed_network                 = try(each.value["managed_network"], null)
  serverless_compute              = try(each.value["serverless_compute"], null)
  timeouts                        = try(each.value["timeouts"], null)
  tags                            = try(each.value["tags"], var.tags)
}
