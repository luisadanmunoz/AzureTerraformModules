#############################################################################
# CONTAINER APP ENVIRONMENT
#############################################################################
resource "azurerm_container_app_environment" "container_app_environment" {
  name                                        = var.container_app_environment_name
  resource_group_name                         = var.resource_group_name
  location                                    = var.location
  dapr_application_insights_connection_string = var.dapr_application_insights_connection_string
  infrastructure_resource_group_name          = var.infrastructure_resource_group_name
  infrastructure_subnet_id                    = var.infrastructure_subnet_id
  internal_load_balancer_enabled              = var.internal_load_balancer_enabled
  log_analytics_workspace_id                  = var.log_analytics_workspace_id
  logs_destination                            = var.logs_destination
  mutual_tls_enabled                          = var.mutual_tls_enabled
  public_network_access                       = var.public_network_access
  zone_redundancy_enabled                     = var.zone_redundancy_enabled
  tags                                        = var.tags

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "workload_profile" {
    for_each = var.workload_profile != null ? var.workload_profile : []

    content {
      name                  = workload_profile.value["name"]
      workload_profile_type = workload_profile.value["workload_profile_type"]
      maximum_count         = try(workload_profile.value["maximum_count"], null)
      minimum_count         = try(workload_profile.value["minimum_count"], null)
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
        var.logs_destination == "log-analytics" &&
        var.log_analytics_workspace_id != null
        ) || (
        var.logs_destination == "azure-monitor" &&
        var.log_analytics_workspace_id == null
        ) || (
        var.logs_destination == null
      )
      error_message = "When logs_destination is log-analytics you must set log_analytics_workspace_id. When logs_destination is azure-monitor log_analytics_workspace_id must be null."
    }

    precondition {
      condition = (
        coalesce(var.internal_load_balancer_enabled, false) == false ||
        var.infrastructure_subnet_id != null
      )
      error_message = "infrastructure_subnet_id is required when internal_load_balancer_enabled is true."
    }

    precondition {
      condition = (
        coalesce(var.zone_redundancy_enabled, false) == false ||
        var.infrastructure_subnet_id != null
      )
      error_message = "infrastructure_subnet_id is required when zone_redundancy_enabled is true."
    }

    precondition {
      condition = (
        var.infrastructure_resource_group_name == null ||
        var.workload_profile != null
      )
      error_message = "infrastructure_resource_group_name is only valid when workload_profile is configured."
    }
  }
}
