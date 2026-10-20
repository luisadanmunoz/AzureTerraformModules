#############################################################################
# MONITOR ACTION GROUP
#############################################################################
resource "azurerm_monitor_action_group" "monitor_action_group" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.short_name
  enabled             = var.enabled
  tags                = var.tags

  dynamic "email_receiver" {
    for_each = coalesce(var.email_receivers, [])

    content {
      name                    = email_receiver.value.name
      email_address           = email_receiver.value.email_address
      use_common_alert_schema = try(email_receiver.value.use_common_alert_schema, true)
    }
  }

  dynamic "webhook_receiver" {
    for_each = coalesce(var.webhook_receivers, [])

    content {
      name                    = webhook_receiver.value.name
      service_uri             = webhook_receiver.value.service_uri
      use_common_alert_schema = try(webhook_receiver.value.use_common_alert_schema, true)
    }
  }

  dynamic "arm_role_receiver" {
    for_each = coalesce(var.arm_role_receivers, [])

    content {
      name                    = arm_role_receiver.value.name
      role_id                 = arm_role_receiver.value.role_id
      use_common_alert_schema = try(arm_role_receiver.value.use_common_alert_schema, true)
    }
  }
}
