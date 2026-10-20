#############################################################################
# KEY VAULT
#############################################################################
resource "azurerm_key_vault" "kv" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  enabled_for_disk_encryption     = false
  enabled_for_deployment          = false
  enabled_for_template_deployment = false
  tenant_id                       = var.tenant_id
  soft_delete_retention_days      = 7
  sku_name                        = var.sku_name
  public_network_access_enabled   = false
  enable_rbac_authorization       = true
  purge_protection_enabled        = true

  tags = var.tags

  network_acls {
    default_action = "Deny"
    bypass         = "None" # Permite que los servicios de Microsoft confiables superen el firewall
  }
}
#############################################################################
# KEY VAULT - PRIVATE ENDPOINT
#############################################################################
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pe-${var.name}"
  location            = azurerm_key_vault.kv.location
  resource_group_name = azurerm_key_vault.kv.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${var.name}"
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdnszg-${var.name}"
    private_dns_zone_ids = [var.private_dns_zone_ids]

  }
  tags = var.tags
}