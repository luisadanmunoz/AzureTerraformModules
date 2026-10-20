#############################################################################
# VIRTUAL DESKTOP SCALING PLAN
#############################################################################
resource "azurerm_virtual_desktop_scaling_plan" "virtual_desktop_scaling_plan" {
  name                = var.virtual_desktop_scaling_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  time_zone           = var.time_zone
  friendly_name       = var.friendly_name
  description         = var.description
  exclusion_tag       = var.exclusion_tag
  tags                = var.tags

  dynamic "host_pool" {
    for_each = var.host_pool != null ? var.host_pool : []

    content {
      hostpool_id          = host_pool.value["hostpool_id"]
      scaling_plan_enabled = host_pool.value["scaling_plan_enabled"]
    }
  }

  dynamic "schedule" {
    for_each = var.schedule

    content {
      name                                 = schedule.value["name"]
      days_of_week                         = schedule.value["days_of_week"]
      ramp_up_start_time                   = schedule.value["ramp_up_start_time"]
      ramp_up_load_balancing_algorithm     = schedule.value["ramp_up_load_balancing_algorithm"]
      ramp_up_minimum_hosts_percent        = try(schedule.value["ramp_up_minimum_hosts_percent"], null)
      ramp_up_capacity_threshold_percent   = try(schedule.value["ramp_up_capacity_threshold_percent"], null)
      peak_start_time                      = schedule.value["peak_start_time"]
      peak_load_balancing_algorithm        = schedule.value["peak_load_balancing_algorithm"]
      ramp_down_start_time                 = schedule.value["ramp_down_start_time"]
      ramp_down_load_balancing_algorithm   = schedule.value["ramp_down_load_balancing_algorithm"]
      ramp_down_minimum_hosts_percent      = schedule.value["ramp_down_minimum_hosts_percent"]
      ramp_down_force_logoff_users         = schedule.value["ramp_down_force_logoff_users"]
      ramp_down_wait_time_minutes          = schedule.value["ramp_down_wait_time_minutes"]
      ramp_down_notification_message       = schedule.value["ramp_down_notification_message"]
      ramp_down_capacity_threshold_percent = schedule.value["ramp_down_capacity_threshold_percent"]
      ramp_down_stop_hosts_when            = schedule.value["ramp_down_stop_hosts_when"]
      off_peak_start_time                  = schedule.value["off_peak_start_time"]
      off_peak_load_balancing_algorithm    = schedule.value["off_peak_load_balancing_algorithm"]
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
      condition     = length(var.schedule) >= 1
      error_message = "At least one schedule block must be defined."
    }
  }
}
