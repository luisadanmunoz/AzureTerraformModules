#############################################################################
# RECOVERY SERVICE VAULT
#############################################################################
module "recovery_service_vault" {
  source = "./modules/recovery_service_vault"

  for_each = var.recovery_service_vault
  #############################################################################
  # RECOVERY SERVICE VAULT VARIABLES
  #############################################################################
  name                = each.value["name"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]
  sku                 = each.value["sku"]
  #############################################################################
  # RECOVERY SERVICE VAULT OUTPUT POLICY VM
  #############################################################################
  name_policy         = each.value["name_policy"]
  recovery_vault_name = each.value["recovery_vault_name"]
  timezone            = each.value["timezone"]
  frequency           = each.value["frequency"]
  time                = each.value["time"]
  retention_daily     = each.value["retention_daily"]
  /*
  retention_weekly          = each.value["retention_weekly"]
  weekdays_weekly           = each.value["weekdays_weekly"]
  retention_monthly         = each.value["retention_monthly"]
  weekdays_monthly          = each.value["weekdays_monthly"]
  weeks_monthly             = each.value["weeks_monthly"]
  retention_yearly          = each.value["retention_yearly"]
  retention_yearly_weekdays = each.value["retention_yearly_weekdays"]
  retention_yearly_weeks    = each.value["retention_yearly_weeks"]
  retention_yearly_months   = each.value["retention_yearly_months"]
  
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
  name_diagnostic_setting   = each.value["name_diagnostic_setting"]
  workspace_resource_id     = element([for k, v in module.log_analytics : v.id if k == each.value["location"]], 0)
*/
  tags = var.tags
}
