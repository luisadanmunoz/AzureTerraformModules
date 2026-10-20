#############################################################################
# MODULE - IOTHUB
#############################################################################

resource "azurerm_iothub" "iothub" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  local_authentication_enabled = true # Abierto

  sku {
    name     = "S1"
    capacity = "1"
  }

  identity {
    type = "SystemAssigned"
  }
  /*
  fallback_route {
    condition = true
  }
 */

  endpoint {
    type                       = "AzureIotHub.StorageContainer"
    connection_string          = var.connection_string_sta
    name                       = "export"
    batch_frequency_in_seconds = 100
    max_chunk_size_in_bytes    = 104857600
    container_name             = var.container_name
    encoding                   = "JSON"
    file_name_format           = "{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}.json.JSON"
  }
  endpoint {
    type              = "AzureIotHub.EventHub"
    connection_string = var.connection_string
    name              = "export2"

  }
  route {
    name           = "export"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["export"]
    enabled        = true
  }
  route {
    name           = "export2"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["export2"]
    enabled        = true
  }
  enrichment {
    key            = "tenant"
    value          = "$twin.tags.Tenant"
    endpoint_names = ["export", "export2"]
  }
  cloud_to_device {
    max_delivery_count = 10
    default_ttl        = "PT1H"
    feedback {
      time_to_live       = "PT1H"
      max_delivery_count = 10
      lock_duration      = "PT1M"
    }
  }

  tags = var.tags

}
#############################################################################
# MODULE - PRIVATE ENDPOINT - privatelink.azure-devices.net
#############################################################################

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pe-${var.name}"
  location            = azurerm_iothub.iothub.location
  resource_group_name = azurerm_iothub.iothub.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${var.name}"
    private_connection_resource_id = azurerm_iothub.iothub.id
    subresource_names              = ["iothub"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdnszg-${var.name}"
    private_dns_zone_ids = var.private_dns_zone_ids

  }

  tags = var.tags
}

resource "azurerm_iothub_device_update_account" "device_update_account" {
  name                = "deviceupdateaccount"
  resource_group_name = azurerm_iothub.iothub.resource_group_name
  location            = azurerm_iothub.iothub.location

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

}
resource "azurerm_iothub_device_update_instance" "device_update_instance" {
  name                     = "poc"
  device_update_account_id = azurerm_iothub_device_update_account.device_update_account.id
  iothub_id                = azurerm_iothub.iothub.id
  diagnostic_enabled       = true

  tags = var.tags


  diagnostic_storage_account {
    connection_string = var.connection_string_diag
    id                = var.sta_id

  }
}
#############################################################################
# MODULE - PRIVATE ENDPOINT - Device Update 
#############################################################################

resource "azurerm_private_endpoint" "private_endpoint_Device_update" {
  name                = "pe-iot-prod-northeurope-adu-001"
  location            = azurerm_iothub.iothub.location
  resource_group_name = azurerm_iothub.iothub.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-iot-prod-northeurope-adu-001"
    private_connection_resource_id = azurerm_iothub_device_update_account.device_update_account.id
    subresource_names              = ["DeviceUpdate"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdnszg-iot-prod-northeurope-adu-001"
    private_dns_zone_ids = var.private_dns_zone_ids

  }

  tags = var.tags
}
