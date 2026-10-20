#############################################################################
# APPLICATION GATEWAY
#############################################################################
locals {
  backend_address_pool_name              = "bapn-pvaks"
  frontend_port_name                     = "fpn-pvaks"
  private_frontend_ip_configuration_name = "ficn-pvaks-private"
  public_frontend_ip_configuration_name  = "ficn-pvaks-public"
  http_setting_name                      = "hsn-pvaks"
  private_listener_name                  = "ln-pvaks-http-private"
  public_listener_name                   = "ln-pvaks-http-public"
  request_routing_rule_name              = "rrrn-pvaks"
  redirect_configuration_name            = "rrn-pvaks"
}

resource "azurerm_application_gateway" "agw" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "ipc-pvaks"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.public_frontend_ip_configuration_name
    public_ip_address_id = var.public_ip_address_id
  }

  frontend_ip_configuration {
    name                          = local.private_frontend_ip_configuration_name
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = "Static"
    subnet_id                     = var.subnet_id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.public_listener_name
    frontend_ip_configuration_name = local.public_frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.public_listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = 1
  }

  #ignore changes since AGW is managed by AGIC
  lifecycle {
    ignore_changes = [
      tags,
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      redirect_configuration,
      request_routing_rule,
      ssl_certificate
    ]
  }

  tags = var.commom_tags

}