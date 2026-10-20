#############################################################################
# MONITOR SCHEDULED QUERY RULES ALERT VARIABLES
#############################################################################
resource "azurerm_monitor_scheduled_query_rules_alert" "disk_space_alert" {
  name                = var.name //"DataDiskFreeSpacePercentageAlert"
  resource_group_name = var.resource_group_name
  location            = var.location
  severity            = var.severity //2
  enabled             = var.enabled
  description         = var.description   //"Log Alert for Virtual Machine Data Disk Free Space Percentage"
  data_source_id      = var.log_analytics # Aquí debes especificar tu Log Analytics Workspace

  # Consulta KQL
  query = var.query

  /*<<-QUERY
    InsightsMetrics
    | where Origin == "vm.azm.ms"
    | where Namespace == "LogicalDisk" and Name == "FreeSpacePercentage"
    | extend Disk=tostring(todynamic(Tags)["vm.azm.ms/mountId"])
    | where Disk !in ('C:','/')
    | summarize AggregatedValue = avg(Val) by bin(TimeGenerated, 15m), Computer, _ResourceId, Disk
  QUERY
  */

  # Configuración de la ventana de tiempo
  time_window = var.time_window //"PT15M"  # Evalúa el promedio en una ventana de 15 minutos
  frequency   = var.frequency   //"PT5M"   # La consulta se ejecuta cada 5 minutos

  # Bloque trigger (disparador de alerta)
  trigger {
    threshold = var.threshold //10       # Alerta cuando el porcentaje de espacio libre es inferior al 10%
    operator  = var.operator  //"LessThan"
  }

  # Bloque action (acción a ejecutar al activarse la alerta)
  action {
    action_group = var.action_group_id //azurerm_monitor_action_group.example.id # Aquí debes especificar tu grupo de acción
  }

}
