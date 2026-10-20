#############################################################################
# COGNITIVE ACCOUNT
#############################################################################
resource "azurerm_cognitive_account" "cognitive_account" {
  name                                         = var.cognitive_account_name
  resource_group_name                          = var.resource_group_name
  location                                     = var.location
  kind                                         = var.kind
  sku_name                                     = var.sku_name
  custom_subdomain_name                        = var.custom_subdomain_name
  dynamic_throttling_enabled                   = var.dynamic_throttling_enabled
  fqdns                                        = var.fqdns
  local_auth_enabled                           = var.local_auth_enabled
  metrics_advisor_aad_client_id                = var.metrics_advisor_aad_client_id
  metrics_advisor_aad_tenant_id                = var.metrics_advisor_aad_tenant_id
  metrics_advisor_super_user_name              = var.metrics_advisor_super_user_name
  metrics_advisor_website_name                 = var.metrics_advisor_website_name
  outbound_network_access_restricted           = var.outbound_network_access_restricted
  project_management_enabled                   = var.project_management_enabled
  public_network_access_enabled                = var.public_network_access_enabled
  qna_runtime_endpoint                         = var.qna_runtime_endpoint
  custom_question_answering_search_service_id  = var.custom_question_answering_search_service_id
  custom_question_answering_search_service_key = var.custom_question_answering_search_service_key
  tags                                         = var.tags

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []

    content {
      key_vault_key_id   = customer_managed_key.value["key_vault_key_id"]
      identity_client_id = try(customer_managed_key.value["identity_client_id"], null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []

    content {
      bypass         = try(network_acls.value["bypass"], null)
      default_action = network_acls.value["default_action"]
      ip_rules       = try(network_acls.value["ip_rules"], null)

      dynamic "virtual_network_rules" {
        for_each = try(network_acls.value["virtual_network_rules"], null) != null ? network_acls.value["virtual_network_rules"] : []

        content {
          subnet_id                            = virtual_network_rules.value["subnet_id"]
          ignore_missing_vnet_service_endpoint = try(virtual_network_rules.value["ignore_missing_vnet_service_endpoint"], null)
        }
      }
    }
  }

  dynamic "network_injection" {
    for_each = var.network_injection != null ? [var.network_injection] : []

    content {
      scenario  = network_injection.value["scenario"]
      subnet_id = network_injection.value["subnet_id"]
    }
  }

  dynamic "storage" {
    for_each = var.storage != null ? [var.storage] : []

    content {
      storage_account_id = storage.value["storage_account_id"]
      identity_client_id = try(storage.value["identity_client_id"], null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition = (
        var.network_acls == null ||
        var.custom_subdomain_name != null
      )
      error_message = "custom_subdomain_name is required when network_acls is specified."
    }

    precondition {
      condition = (
        coalesce(var.project_management_enabled, false) == false ||
        var.kind == "AIServices"
      )
      error_message = "project_management_enabled can only be true when kind is AIServices."
    }

    precondition {
      condition = (
        var.network_injection == null ||
        var.kind == "AIServices"
      )
      error_message = "network_injection is only supported when kind is AIServices."
    }
  }
}
