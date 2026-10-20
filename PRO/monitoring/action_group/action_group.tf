#############################################################################
# ACTION GROUP ACTION OUTPUT
#############################################################################
resource "azurerm_monitor_action_group" "action_group" {
  name                = var.name
  resource_group_name = var.resource_group
  short_name          = var.short_name

  webhook_receiver {
    name                    = var.name_webhook
    service_uri             = var.uri
    use_common_alert_schema = true
  }

  tags = var.commom_tags
  #############################################################################
  # EMAIL 1
  #############################################################################
  email_receiver {
    name                    = var.name_email
    email_address           = var.email
    use_common_alert_schema = true
  }
  #############################################################################
  # EMAIL 2
  #############################################################################
  email_receiver {
    name                    = var.name_email2
    email_address           = var.email2
    use_common_alert_schema = true
  }


}