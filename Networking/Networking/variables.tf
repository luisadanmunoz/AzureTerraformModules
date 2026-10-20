#############################################################################
# GLOBAL TAGS
#############################################################################
variable "tags" {
  description = "value to set the global tags"
  type        = map(string)
  default     = {}
}

#############################################################################
# RESOURCE GROUPS
#############################################################################
variable "resources_groups" {
  description = "value to set the resources groups"
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(string))
  }))
  default = {}
}

#############################################################################
# VIRTUAL NETWORKS
#############################################################################
variable "virtual_networks" {
  description = "value to set the virtual networks"
  type = map(object({
    virtual_network_name = string
    resource_group_name  = optional(string)
    location             = string
    address_space        = list(string)
    dns_servers          = optional(list(string))
    tags                 = optional(map(string))
  }))
  default = {}
}

#############################################################################
# SUBNETS
#############################################################################
variable "subnets" {
  description = "value to set the subnets"
  type = map(object({
    subnet_name                           = string
    resource_group_name                   = optional(string)
    virtual_network_name                  = optional(string)
    address_prefixes                      = list(string)
    service_endpoints                     = optional(list(string))
    service_endpoint_policy_ids           = optional(list(string))
    private_endpoint_network_policies     = optional(string)
    private_link_service_network_policies = optional(bool)
    delegations = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    })))
    nsg_name         = optional(string)
    nsg_id           = optional(string)
    route_table_name = optional(string)
    route_table_id   = optional(string)
    nat_gateway_name = optional(string)
    nat_gateway_id   = optional(string)
  }))
  default = {}
}

#############################################################################
# NETWORK SECURITY GROUPS
#############################################################################
variable "network_security_groups" {
  description = "value to set the network security groups"
  type = map(object({
    nsg_name            = string
    resource_group_name = optional(string)
    location            = string
    security_rules = optional(list(object({
      name                                       = string
      priority                                   = number
      direction                                  = string
      access                                     = string
      protocol                                   = string
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      source_address_prefix                      = optional(string)
      source_address_prefixes                    = optional(list(string))
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      description                                = optional(string)
    })))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# ROUTE TABLES
#############################################################################
variable "route_tables" {
  description = "value to set the route tables"
  type = map(object({
    route_table_name              = string
    resource_group_name           = optional(string)
    location                      = string
    bgp_route_propagation_enabled = optional(bool)
    routes = optional(list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    })))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# PUBLIC IPS
#############################################################################
variable "public_ips" {
  description = "value to set the public ips"
  type = map(object({
    public_ip_name          = string
    resource_group_name     = optional(string)
    location                = string
    allocation_method       = string
    sku                     = optional(string)
    sku_tier                = optional(string)
    domain_name_label       = optional(string)
    reverse_fqdn            = optional(string)
    ip_version              = optional(string)
    idle_timeout_in_minutes = optional(number)
    zones                   = optional(list(string))
    tags                    = optional(map(string))
  }))
  default = {}
}

#############################################################################
# NAT GATEWAYS
#############################################################################
variable "nat_gateways" {
  description = "value to set the nat gateways"
  type = map(object({
    nat_gateway_name        = string
    resource_group_name     = optional(string)
    location                = string
    sku_name                = optional(string)
    idle_timeout_in_minutes = optional(number)
    public_ip_names         = optional(list(string))
    public_ip_ids           = optional(list(string))
    public_ip_prefix_ids    = optional(list(string))
    tags                    = optional(map(string))
  }))
  default = {}
}

#############################################################################
# PRIVATE DNS ZONES
#############################################################################
variable "private_dns_zones" {
  description = "value to set the private dns zones"
  type = map(object({
    private_dns_zone_name = string
    resource_group_name   = optional(string)
    tags                  = optional(map(string))
  }))
  default = {}
}

#############################################################################
# PRIVATE DNS ZONE VIRTUAL NETWORK LINKS
#############################################################################
variable "private_dns_zone_virtual_network_links" {
  description = "value to set the private dns zone virtual network links"
  type = map(object({
    private_dns_zone_virtual_network_link_name = string
    resource_group_name                        = optional(string)
    private_dns_zone_name                      = optional(string)
    virtual_network_name                       = optional(string)
    virtual_network_id                         = optional(string)
    registration_enabled                       = optional(bool)
    tags                                       = optional(map(string))
  }))
  default = {}
}

#############################################################################
# PRIVATE ENDPOINTS
#############################################################################
variable "private_endpoints" {
  description = "value to set the private endpoints"
  type = map(object({
    private_endpoint_name           = string
    resource_group_name             = optional(string)
    location                        = string
    subnet_name                     = optional(string)
    subnet_id                       = optional(string)
    custom_network_interface_name   = optional(string)
    private_service_connection_name = optional(string)
    private_connection_resource_id  = string
    subresource_names               = list(string)
    is_manual_connection            = optional(bool)
    request_message                 = optional(string)
    private_dns_zone_group_name     = optional(string)
    private_dns_zone_names          = optional(list(string))
    private_dns_zone_ids            = optional(list(string))
    tags                            = optional(map(string))
  }))
  default = {}
}

#############################################################################
# NETWORK WATCHERS
#############################################################################
variable "network_watchers" {
  description = "value to set the network watchers"
  type = map(object({
    network_watcher_name = string
    resource_group_name  = optional(string)
    location             = string
    tags                 = optional(map(string))
  }))
  default = {}
}

#############################################################################
# BASTION HOSTS
#############################################################################
variable "bastion_hosts" {
  description = "value to set the bastion hosts"
  type = map(object({
    bastion_host_name      = string
    resource_group_name    = optional(string)
    location               = string
    subnet_name            = optional(string)
    subnet_id              = optional(string)
    public_ip_name         = optional(string)
    public_ip_id           = optional(string)
    sku                    = optional(string)
    scale_units            = optional(number)
    copy_paste_enabled     = optional(bool)
    file_copy_enabled      = optional(bool)
    ip_connect_enabled     = optional(bool)
    shareable_link_enabled = optional(bool)
    tunneling_enabled      = optional(bool)
    zones                  = optional(list(string))
    tags                   = optional(map(string))
  }))
  default = {}
}

#############################################################################
# LOAD BALANCERS
#############################################################################
variable "load_balancers" {
  description = "value to set the load balancers"
  type = map(object({
    load_balancer_name  = string
    resource_group_name = optional(string)
    location            = string
    sku                 = optional(string)
    sku_tier            = optional(string)
    edge_zone           = optional(string)
    tags                = optional(map(string))
    frontend_ip_configurations = list(object({
      name                          = string
      subnet_name                   = optional(string)
      subnet_id                     = optional(string)
      private_ip_address            = optional(string)
      private_ip_address_allocation = optional(string)
      private_ip_address_version    = optional(string)
      public_ip_name                = optional(string)
      public_ip_id                  = optional(string)
      public_ip_prefix_id           = optional(string)
      zones                         = optional(list(string))
    }))
    backend_address_pools = optional(list(object({
      name = string
    })))
    probes = optional(list(object({
      name                = string
      protocol            = string
      port                = number
      request_path        = optional(string)
      interval_in_seconds = optional(number)
      number_of_probes    = optional(number)
    })))
    rules = optional(list(object({
      name                           = string
      protocol                       = string
      frontend_port                  = number
      backend_port                   = number
      frontend_ip_configuration_name = string
      backend_address_pool_name      = optional(string)
      probe_name                     = optional(string)
      enable_floating_ip             = optional(bool)
      idle_timeout_in_minutes        = optional(number)
      load_distribution              = optional(string)
      disable_outbound_snat          = optional(bool)
      tcp_reset_enabled              = optional(bool)
    })))
  }))
  default = {}
}

#############################################################################
# VNET PEERINGS
#############################################################################
variable "virtual_network_peerings" {
  description = "value to set the virtual network peerings"
  type = map(object({
    peering_name                 = string
    resource_group_name          = optional(string)
    virtual_network_name         = optional(string)
    remote_virtual_network_name  = optional(string)
    remote_virtual_network_id    = optional(string)
    allow_virtual_network_access = optional(bool)
    allow_forwarded_traffic      = optional(bool)
    allow_gateway_transit        = optional(bool)
    use_remote_gateways          = optional(bool)
  }))
  default = {}
}
