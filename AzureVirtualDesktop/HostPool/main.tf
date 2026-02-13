################################################################################
# AVD Host Pool
################################################################################

resource "azurerm_virtual_desktop_host_pool" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # Pool Configuration
  type                             = var.type
  load_balancer_type               = var.load_balancer_type
  friendly_name                    = var.friendly_name
  description                      = var.description
  validate_environment             = var.validate_environment
  start_vm_on_connect              = var.start_vm_on_connect
  custom_rdp_properties            = var.custom_rdp_properties
  personal_desktop_assignment_type = local.is_personal ? var.personal_desktop_assignment_type : null
  maximum_sessions_allowed         = local.is_pooled ? var.maximum_sessions_allowed : null
  preferred_app_group_type         = var.preferred_app_group_type

  # Scheduled Agent Updates
  dynamic "scheduled_agent_updates" {
    for_each = var.scheduled_agent_updates != null ? [var.scheduled_agent_updates] : []
    content {
      enabled                   = scheduled_agent_updates.value.enabled
      timezone                  = scheduled_agent_updates.value.timezone
      use_session_host_timezone = scheduled_agent_updates.value.use_session_host_timezone

      dynamic "schedule" {
        for_each = scheduled_agent_updates.value.schedule != null ? scheduled_agent_updates.value.schedule : []
        content {
          day_of_week = schedule.value.day_of_week
          hour_of_day = schedule.value.hour_of_day
        }
      }
    }
  }

  tags = local.tags
}

################################################################################
# Registration Token
################################################################################

resource "azurerm_virtual_desktop_host_pool_registration_info" "this" {
  count = var.create && var.registration_expiration_date != null ? 1 : 0

  hostpool_id     = azurerm_virtual_desktop_host_pool.this[0].id
  expiration_date = var.registration_expiration_date
}
