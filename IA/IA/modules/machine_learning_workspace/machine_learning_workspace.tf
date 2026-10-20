#############################################################################
# MACHINE LEARNING WORKSPACE
#############################################################################
resource "azurerm_machine_learning_workspace" "machine_learning_workspace" {
  name                            = var.machine_learning_workspace_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  application_insights_id         = var.application_insights_id
  key_vault_id                    = var.key_vault_id
  storage_account_id              = var.storage_account_id
  container_registry_id           = var.container_registry_id
  description                     = var.description
  friendly_name                   = var.friendly_name
  high_business_impact            = var.high_business_impact
  image_build_compute_name        = var.image_build_compute_name
  kind                            = var.kind
  primary_user_assigned_identity  = var.primary_user_assigned_identity
  public_network_access_enabled   = var.public_network_access_enabled
  service_side_encryption_enabled = var.service_side_encryption_enabled
  sku_name                        = var.sku_name
  v1_legacy_mode_enabled          = var.v1_legacy_mode_enabled
  tags                            = var.tags

  identity {
    type         = var.identity["type"]
    identity_ids = try(var.identity["identity_ids"], null)
  }

  dynamic "encryption" {
    for_each = var.encryption != null ? [var.encryption] : []

    content {
      key_id                    = encryption.value["key_id"]
      key_vault_id              = encryption.value["key_vault_id"]
      user_assigned_identity_id = try(encryption.value["user_assigned_identity_id"], null)
    }
  }

  dynamic "feature_store" {
    for_each = var.feature_store != null ? [var.feature_store] : []

    content {
      computer_spark_runtime_version = try(feature_store.value["computer_spark_runtime_version"], null)
      offline_connection_name        = try(feature_store.value["offline_connection_name"], null)
      online_connection_name         = try(feature_store.value["online_connection_name"], null)
    }
  }

  dynamic "managed_network" {
    for_each = var.managed_network != null ? [var.managed_network] : []

    content {
      isolation_mode                = try(managed_network.value["isolation_mode"], null)
      provision_on_creation_enabled = try(managed_network.value["provision_on_creation_enabled"], null)
    }
  }

  dynamic "serverless_compute" {
    for_each = var.serverless_compute != null ? [var.serverless_compute] : []

    content {
      public_ip_enabled = try(serverless_compute.value["public_ip_enabled"], null)
      subnet_id         = try(serverless_compute.value["subnet_id"], null)
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
        var.kind != "FeatureStore" ||
        var.feature_store != null
      )
      error_message = "feature_store must be set when kind is FeatureStore."
    }

    precondition {
      condition = (
        coalesce(var.service_side_encryption_enabled, false) == false ||
        var.encryption != null
      )
      error_message = "encryption must be set when service_side_encryption_enabled is true."
    }
  }
}
