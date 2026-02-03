################################################################################
# Private Link Service
################################################################################

# DEPENDENCY: Resource Group, Standard Load Balancer, and Subnet(s) must exist
resource "azurerm_private_link_service" "this" {
  count = var.create ? 1 : 0

  name                = local.pls_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location

  load_balancer_frontend_ip_configuration_ids = var.load_balancer_frontend_ip_configuration_ids # DEPENDENCY: Standard Load Balancer

  # DEPENDENCY: Subnet(s) must exist with private link service network policies disabled
  dynamic "nat_ip_configuration" {
    for_each = var.nat_ip_configuration

    content {
      name                       = nat_ip_configuration.value.name
      subnet_id                  = nat_ip_configuration.value.subnet_id # DEPENDENCY: Subnet
      primary                    = nat_ip_configuration.value.primary
      private_ip_address         = nat_ip_configuration.value.private_ip_address
      private_ip_address_version = nat_ip_configuration.value.private_ip_address_version
    }
  }

  auto_approval_subscription_ids = var.auto_approval_subscription_ids
  visibility_subscription_ids    = var.visibility_subscription_ids
  enable_proxy_protocol          = var.enable_proxy_protocol
  fqdns                          = var.fqdns

  tags = local.tags
}
