#############################################################################
# APP SERVICE PLAN
#############################################################################
resource "azurerm_app_service_plan" "iot_function" {
  name                = var.name_app_service_plan
  location            = var.location
  resource_group_name = var.resource_group_name

  sku { # Uso Linux
    tier = "Standard"
    size = "S1"
  }
  tags = var.tags
}

resource "azurerm_function_app" "iot_function" {
  name                       = var.name_function_app
  location                   = azurerm_app_service_plan.iot_function.location
  resource_group_name        = azurerm_app_service_plan.iot_function.resource_group_name
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  app_service_plan_id        = azurerm_app_service_plan.iot_function.id
  os_type                    = "linux"
  version                    = "~4"

  tags = var.tags
}

/*  
  # Configuración para conectarse al IoT Hub
  app_settings = {
    "AzureWebJobsStorage"        = var.AzureWebJobsStorage //azurerm_storage_account.sa.primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME"   = "python"
    "IoTHubConnectionString"     = "Your_IoTHub_Connection_String"
  }
}

*/
#############################################################################
# MODULE - PRIVATE ENDPOINT - privatelink.azure-devices.net
#############################################################################

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pe-${var.name_function_app}"
  location            = azurerm_app_service_plan.iot_function.location
  resource_group_name = azurerm_app_service_plan.iot_function.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${var.name_function_app}"
    private_connection_resource_id = azurerm_function_app.iot_function.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdnszg-${var.name_function_app}"
    private_dns_zone_ids = [var.private_dns_zone_ids]

  }

  tags = var.tags
}

