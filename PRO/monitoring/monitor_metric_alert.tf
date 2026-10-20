#############################################################################
# MONITOR METRIC ALERTS
#############################################################################
module "monitor_metric_alert" {
  source = "./modules/monitor_metric_alert"

  for_each = var.monitor_metric_alert

  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]

  scopes = (
    length(each.value["scopes"]) > 0 && can(length(each.value["scopes"])) ? # Verifica si es una lista
    [
      for s in each.value["scopes"] :
      element([
        for v in concat(
          values(module.express_route),
          values(module.vng),
          values(module.windows_vm),
          values(module.private_dns_zone),
          values(module.keyvault),
          values(module.public_ip),
          values(module.local_network_gateway),
          values(module.vnet)
        ) : v.id if v.name == s
      ], 0)
    ] :
    [ # Maneja el caso en que solo hay un valor en `scopes`
      element([
        for v in concat(
          values(module.express_route),
          values(module.vng),
          values(module.windows_vm),
          values(module.private_dns_zone),
          values(module.keyvault),
          values(module.public_ip),
          values(module.local_network_gateway)
        ) : v.id if v.name == each.value["scopes"]
      ], 0)
    ]
  )

  description      = each.value["description"]
  severity         = each.value["severity"]
  enabled          = each.value["enabled"]
  frequency        = each.value["frequency"]
  window_size      = each.value["window_size"]
  auto_mitigate    = each.value["auto_mitigate"]
  metric_namespace = each.value["metric_namespace"]
  metric_name      = each.value["metric_name"]
  aggregation      = each.value["aggregation"]
  operator         = each.value["operator"]
  threshold        = each.value["threshold"]
  action_group_id  = element([for k, v in module.action_group : v.id if v.name == each.value["action_group"]], 0)
}

