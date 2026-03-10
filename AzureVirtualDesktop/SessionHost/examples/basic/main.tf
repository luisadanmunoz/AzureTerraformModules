################################################################################
# Example: Complete AVD Deployment with Session Hosts
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

# ──────────────────────────────────────────────────────────────────────────────
# Resource Group
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_resource_group" "example" {
  name     = "rg-avd-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Networking
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_network" "example" {
  name                = "vnet-avd-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "sessionhosts" {
  name                 = "snet-sessionhosts"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# ──────────────────────────────────────────────────────────────────────────────
# Host Pool
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_desktop_host_pool" "example" {
  name                = "vdpool-general-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  type                     = "Pooled"
  load_balancer_type       = "BreadthFirst"
  maximum_sessions_allowed = 10
  start_vm_on_connect      = true
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "example" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.example.id
  expiration_date = timeadd(timestamp(), "48h")
}

# ──────────────────────────────────────────────────────────────────────────────
# Application Group
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_desktop_application_group" "example" {
  name                = "vdag-desktop-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  host_pool_id        = azurerm_virtual_desktop_host_pool.example.id
  type                = "Desktop"
  friendly_name       = "Full Desktop"
}

# ──────────────────────────────────────────────────────────────────────────────
# Workspace
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_desktop_workspace" "example" {
  name                = "vdws-general-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  friendly_name       = "Development Workspace"
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "example" {
  workspace_id         = azurerm_virtual_desktop_workspace.example.id
  application_group_id = azurerm_virtual_desktop_application_group.example.id
}

# ──────────────────────────────────────────────────────────────────────────────
# Session Hosts Module
# ──────────────────────────────────────────────────────────────────────────────

module "session_hosts" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Naming
  name_prefix = "vdsh"
  workload    = "general"
  environment = "dev"

  # VM Configuration
  instance_count = 2
  vm_size        = "Standard_D4s_v5"
  admin_username = "avdadmin"
  # admin_password will be auto-generated

  # Networking
  subnet_id = azurerm_subnet.sessionhosts.id

  # Host Pool Registration
  hostpool_id        = azurerm_virtual_desktop_host_pool.example.id
  registration_token = azurerm_virtual_desktop_host_pool_registration_info.example.token

  # Azure AD Join
  domain_join_type = "AzureAD"
  aad_join = {
    intune_enrollment = false
  }

  # OS Image - Windows 11 Multi-session
  source_image_reference = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-23h2-avd"
    version   = "latest"
  }

  # OS Disk
  os_disk = {
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 128
  }

  # Security
  secure_boot_enabled = true
  vtpm_enabled        = true

  tags = {
    Environment = "Development"
    Purpose     = "AVD Session Hosts"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "hostpool_id" {
  description = "The ID of the Host Pool"
  value       = azurerm_virtual_desktop_host_pool.example.id
}

output "workspace_id" {
  description = "The ID of the Workspace"
  value       = azurerm_virtual_desktop_workspace.example.id
}

output "session_host_names" {
  description = "The names of the Session Host VMs"
  value       = module.session_hosts.vm_names
}

output "session_host_ips" {
  description = "The private IPs of the Session Host VMs"
  value       = module.session_hosts.private_ip_addresses
}

output "admin_password" {
  description = "The admin password for the Session Host VMs"
  value       = module.session_hosts.admin_password
  sensitive   = true
}
