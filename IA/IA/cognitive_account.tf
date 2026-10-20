#############################################################################
# COGNITIVE ACCOUNTS
#############################################################################
module "cognitive_account" {
  source = "./modules/cognitive_account"

  for_each = var.cognitive_accounts

  cognitive_account_name = each.value["cognitive_account_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                                     = each.value["location"]
  kind                                         = each.value["kind"]
  sku_name                                     = each.value["sku_name"]
  custom_subdomain_name                        = try(each.value["custom_subdomain_name"], null)
  dynamic_throttling_enabled                   = try(each.value["dynamic_throttling_enabled"], null)
  fqdns                                        = try(each.value["fqdns"], null)
  local_auth_enabled                           = try(each.value["local_auth_enabled"], null)
  metrics_advisor_aad_client_id                = try(each.value["metrics_advisor_aad_client_id"], null)
  metrics_advisor_aad_tenant_id                = try(each.value["metrics_advisor_aad_tenant_id"], null)
  metrics_advisor_super_user_name              = try(each.value["metrics_advisor_super_user_name"], null)
  metrics_advisor_website_name                 = try(each.value["metrics_advisor_website_name"], null)
  outbound_network_access_restricted           = try(each.value["outbound_network_access_restricted"], null)
  project_management_enabled                   = try(each.value["project_management_enabled"], null)
  public_network_access_enabled                = try(each.value["public_network_access_enabled"], null)
  qna_runtime_endpoint                         = try(each.value["qna_runtime_endpoint"], null)
  custom_question_answering_search_service_id  = try(each.value["custom_question_answering_search_service_id"], null)
  custom_question_answering_search_service_key = try(each.value["custom_question_answering_search_service_key"], null)
  customer_managed_key                         = try(each.value["customer_managed_key"], null)
  identity                                     = try(each.value["identity"], null)
  network_acls                                 = try(each.value["network_acls"], null)
  network_injection                            = try(each.value["network_injection"], null)
  storage                                      = try(each.value["storage"], null)
  timeouts                                     = try(each.value["timeouts"], null)
  tags                                         = try(each.value["tags"], var.tags)
}
