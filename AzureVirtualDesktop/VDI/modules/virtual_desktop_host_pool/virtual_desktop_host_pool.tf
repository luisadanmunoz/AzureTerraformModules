#############################################################################
# VIRTUAL DESKTOP HOST POOL
#############################################################################
resource "azurerm_virtual_desktop_host_pool" "virtual_desktop_host_pool" {
  name                             = var.virtual_desktop_host_pool_name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  type                             = var.type
  load_balancer_type               = var.load_balancer_type
  friendly_name                    = var.friendly_name
  description                      = var.description
  validate_environment             = var.validate_environment
  start_vm_on_connect              = var.start_vm_on_connect
  custom_rdp_properties            = var.custom_rdp_properties
  personal_desktop_assignment_type = var.personal_desktop_assignment_type
  public_network_access            = var.public_network_access
  maximum_sessions_allowed         = var.maximum_sessions_allowed
  preferred_app_group_type         = var.preferred_app_group_type
  vm_template                      = var.vm_template
  tags                             = var.tags

  dynamic "scheduled_agent_updates" {
    for_each = var.scheduled_agent_updates != null ? [var.scheduled_agent_updates] : []

    content {
      enabled                   = try(scheduled_agent_updates.value["enabled"], null)
      timezone                  = try(scheduled_agent_updates.value["timezone"], null)
      use_session_host_timezone = try(scheduled_agent_updates.value["use_session_host_timezone"], null)

      dynamic "schedule" {
        for_each = try(scheduled_agent_updates.value["schedule"], [])

        content {
          day_of_week = schedule.value["day_of_week"]
          hour_of_day = schedule.value["hour_of_day"]
        }
      }
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
        var.type != "Personal" ||
        var.personal_desktop_assignment_type != null
      )
      error_message = "personal_desktop_assignment_type is required when type is Personal."
    }

    precondition {
      condition = (
        var.type != "Personal" ||
        var.load_balancer_type == "Persistent"
      )
      error_message = "load_balancer_type must be Persistent when type is Personal."
    }

    precondition {
      condition = (
        var.type != "Pooled" ||
        var.load_balancer_type != "Persistent"
      )
      error_message = "load_balancer_type cannot be Persistent when type is Pooled."
    }

    precondition {
      condition = (
        var.type != "Personal" ||
        var.maximum_sessions_allowed == null
      )
      error_message = "maximum_sessions_allowed should not be set when type is Personal."
    }

    precondition {
      condition = (
        var.scheduled_agent_updates == null ||
        try(var.scheduled_agent_updates["enabled"], false) == false ||
        (
          length(try(var.scheduled_agent_updates["schedule"], [])) >= 1 &&
          length(try(var.scheduled_agent_updates["schedule"], [])) <= 2
        )
      )
      error_message = "When scheduled_agent_updates.enabled is true, between one and two schedule blocks must be defined."
    }
  }
}
