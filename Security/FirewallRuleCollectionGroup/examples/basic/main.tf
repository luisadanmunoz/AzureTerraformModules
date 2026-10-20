################################################################################
# Example: Azure Firewall Policy Rule Collection Group
# Demonstrates all three rule collection types
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-firewall-rules-prod-001"
  location = "westeurope"
}

################################################################################
# Network Infrastructure
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-hub-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "firewall" {
  name                = "pip-fw-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

################################################################################
# Firewall Policy
################################################################################

resource "azurerm_firewall_policy" "example" {
  name                = "fwpol-hub-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"
}

################################################################################
# Firewall
################################################################################

resource "azurerm_firewall" "example" {
  name                = "fw-hub-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.example.id

  ip_configuration {
    name                 = "ipconfig1"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

################################################################################
# Rule Collection Group - NAT Rules (Priority 100)
# Inbound DNAT rules for exposing internal services
################################################################################

module "rcg_nat" {
  source = "../../"

  name               = "rcg-nat-inbound"
  firewall_policy_id = azurerm_firewall_policy.example.id
  priority           = 100

  nat_rule_collections = [
    {
      name     = "dnat-web-servers"
      priority = 1000
      action   = "Dnat"
      rules = [
        {
          name                = "dnat-https-to-webserver"
          description         = "DNAT HTTPS traffic to internal web server"
          source_addresses    = ["*"]
          destination_address = azurerm_public_ip.firewall.ip_address
          destination_ports   = ["443"]
          protocols           = ["TCP"]
          translated_address  = "10.0.10.4"
          translated_port     = "443"
        },
        {
          name                = "dnat-ssh-to-jumpbox"
          description         = "DNAT SSH traffic to internal jumpbox"
          source_addresses    = ["203.0.113.0/24"]
          destination_address = azurerm_public_ip.firewall.ip_address
          destination_ports   = ["2222"]
          protocols           = ["TCP"]
          translated_address  = "10.0.10.5"
          translated_port     = "22"
        }
      ]
    }
  ]
}

################################################################################
# Rule Collection Group - Network Rules (Priority 200)
# Outbound network-level filtering
################################################################################

module "rcg_network" {
  source = "../../"

  name               = "rcg-network-outbound"
  firewall_policy_id = azurerm_firewall_policy.example.id
  priority           = 200

  network_rule_collections = [
    {
      name     = "allow-infrastructure"
      priority = 1000
      action   = "Allow"
      rules = [
        {
          name                  = "allow-dns"
          description           = "Allow DNS queries to Azure DNS"
          source_addresses      = ["10.0.0.0/8"]
          destination_addresses = ["168.63.129.16"]
          destination_ports     = ["53"]
          protocols             = ["UDP", "TCP"]
        },
        {
          name                  = "allow-ntp"
          description           = "Allow NTP time synchronization"
          source_addresses      = ["10.0.0.0/8"]
          destination_addresses = ["*"]
          destination_ports     = ["123"]
          protocols             = ["UDP"]
        }
      ]
    },
    {
      name     = "allow-database"
      priority = 1100
      action   = "Allow"
      rules = [
        {
          name                  = "allow-sql"
          description           = "Allow SQL traffic to database subnet"
          source_addresses      = ["10.0.2.0/24"]
          destination_addresses = ["10.0.3.0/24"]
          destination_ports     = ["1433"]
          protocols             = ["TCP"]
        }
      ]
    }
  ]
}

################################################################################
# Rule Collection Group - Application Rules (Priority 300)
# Outbound application-level filtering (FQDN-based)
################################################################################

module "rcg_application" {
  source = "../../"

  name               = "rcg-application-outbound"
  firewall_policy_id = azurerm_firewall_policy.example.id
  priority           = 300

  application_rule_collections = [
    {
      name     = "allow-web-traffic"
      priority = 1000
      action   = "Allow"
      rules = [
        {
          name              = "allow-microsoft-updates"
          description       = "Allow Windows Update and Microsoft services"
          source_addresses  = ["10.0.0.0/8"]
          destination_fqdns = ["*.microsoft.com", "*.windowsupdate.com", "*.azure.com"]
          protocols = [
            {
              type = "Https"
              port = 443
            }
          ]
        },
        {
          name              = "allow-app-dependencies"
          description       = "Allow application HTTPS dependencies"
          source_addresses  = ["10.0.2.0/24"]
          destination_fqdns = ["api.example.com", "cdn.example.com"]
          protocols = [
            {
              type = "Https"
              port = 443
            },
            {
              type = "Http"
              port = 80
            }
          ]
        }
      ]
    }
  ]
}

################################################################################
# Outputs
################################################################################

output "nat_rule_collection_group_id" {
  value = module.rcg_nat.id
}

output "network_rule_collection_group_id" {
  value = module.rcg_network.id
}

output "application_rule_collection_group_id" {
  value = module.rcg_application.id
}
