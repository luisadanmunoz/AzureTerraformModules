################################################################################
# Provider Configuration
################################################################################

provider "azurerm" {
  features {}
}

################################################################################
# Resource Group
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-frontdoor-basic-example"
  location = "East US"
}

################################################################################
# Front Door Module - Basic Example
################################################################################

module "front_door" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  workload            = "webapp"
  environment         = "dev"
  instance            = "001"

  sku_name                 = "Standard_AzureFrontDoor"
  response_timeout_seconds = 120

  # Single endpoint
  endpoints = [
    {
      name    = "ep-webapp"
      enabled = true
    }
  ]

  # Single origin group with health probe and load balancing
  origin_groups = [
    {
      name                     = "og-webapp"
      session_affinity_enabled = false
      restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10
      health_probe = {
        interval_in_seconds = 100
        path                = "/"
        protocol            = "Https"
        request_type        = "HEAD"
      }
      load_balancing = {
        additional_latency_in_milliseconds = 50
        sample_size                        = 4
        successful_samples_required        = 3
      }
    }
  ]

  # Single origin pointing to an Azure App Service
  origins = [
    {
      name                           = "origin-webapp"
      origin_group_name              = "og-webapp"
      host_name                      = "mywebapp.azurewebsites.net"
      http_port                      = 80
      https_port                     = 443
      origin_host_header             = "mywebapp.azurewebsites.net"
      priority                       = 1
      weight                         = 1000
      enabled                        = true
      certificate_name_check_enabled = true
    }
  ]

  # Single route matching all traffic
  routes = [
    {
      name                   = "route-default"
      endpoint_name          = "ep-webapp"
      origin_group_name      = "og-webapp"
      origin_names           = ["origin-webapp"]
      patterns_to_match      = ["/*"]
      supported_protocols    = ["Http", "Https"]
      forwarding_protocol    = "HttpsOnly"
      https_redirect_enabled = true
      link_to_default_domain = true
    }
  ]

  tags = {
    example = "basic"
  }
}

################################################################################
# Outputs
################################################################################

output "front_door_profile_id" {
  description = "The ID of the Front Door profile."
  value       = module.front_door.profile_id
}

output "front_door_profile_name" {
  description = "The name of the Front Door profile."
  value       = module.front_door.profile_name
}

output "front_door_endpoint_host_names" {
  description = "The endpoint host names."
  value       = module.front_door.endpoint_host_names
}
