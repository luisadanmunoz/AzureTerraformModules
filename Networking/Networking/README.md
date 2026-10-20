# Networking Azure con Terraform

Catálogo base de networking para Azure siguiendo la misma estructura que `Gobernanza`.

## Módulos incluidos

- `rg`
- `vnet`
- `subnet`
- `nsg`
- `route_table`
- `public_ip`
- `nat_gateway`
- `private_dns_zone`
- `private_dns_zone_virtual_network_link`
- `private_endpoint`
- `vnet_peering`
- `network_watcher`
- `bastion_host`
- `load_balancer`

## Estrategia de uso

- usa `*_name` cuando el recurso nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- arranca por `rg`, `vnet`, `nsg`, `route_table` y `subnet`
- añade `nat_gateway`, `private_dns_zone`, `private_dns_zone_virtual_network_link`, `private_endpoint` y `vnet_peering` después
- usa `bastion_host` sobre una subnet dedicada `AzureBastionSubnet`
- usa `load_balancer` con `Standard SKU` como opción preferente en entornos corporativos
- crea `network_watcher` por región cuando quieras habilitar observabilidad de red

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0, < 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_bastion_host"></a> [bastion\_host](#module\_bastion\_host) | ./modules/bastion_host | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./modules/load_balancer | n/a |
| <a name="module_nat_gateway"></a> [nat\_gateway](#module\_nat\_gateway) | ./modules/nat_gateway | n/a |
| <a name="module_network_watcher"></a> [network\_watcher](#module\_network\_watcher) | ./modules/network_watcher | n/a |
| <a name="module_nsg"></a> [nsg](#module\_nsg) | ./modules/nsg | n/a |
| <a name="module_private_dns_zone"></a> [private\_dns\_zone](#module\_private\_dns\_zone) | ./modules/private_dns_zone | n/a |
| <a name="module_private_dns_zone_virtual_network_link"></a> [private\_dns\_zone\_virtual\_network\_link](#module\_private\_dns\_zone\_virtual\_network\_link) | ./modules/private_dns_zone_virtual_network_link | n/a |
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | ./modules/private_endpoint | n/a |
| <a name="module_public_ip"></a> [public\_ip](#module\_public\_ip) | ./modules/public_ip | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ./modules/rg | n/a |
| <a name="module_route_table"></a> [route\_table](#module\_route\_table) | ./modules/route_table | n/a |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnet | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |
| <a name="module_vnet_peering"></a> [vnet\_peering](#module\_vnet\_peering) | ./modules/vnet_peering | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_bastion_hosts"></a> [bastion\_hosts](#input\_bastion\_hosts) | value to set the bastion hosts | <pre>map(object({<br/>    bastion_host_name      = string<br/>    resource_group_name    = optional(string)<br/>    location               = string<br/>    subnet_name            = optional(string)<br/>    subnet_id              = optional(string)<br/>    public_ip_name         = optional(string)<br/>    public_ip_id           = optional(string)<br/>    sku                    = optional(string)<br/>    scale_units            = optional(number)<br/>    copy_paste_enabled     = optional(bool)<br/>    file_copy_enabled      = optional(bool)<br/>    ip_connect_enabled     = optional(bool)<br/>    shareable_link_enabled = optional(bool)<br/>    tunneling_enabled      = optional(bool)<br/>    zones                  = optional(list(string))<br/>    tags                   = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | value to set the load balancers | <pre>map(object({<br/>    load_balancer_name  = string<br/>    resource_group_name = optional(string)<br/>    location            = string<br/>    sku                 = optional(string)<br/>    sku_tier            = optional(string)<br/>    edge_zone           = optional(string)<br/>    tags                = optional(map(string))<br/>    frontend_ip_configurations = list(object({<br/>      name                          = string<br/>      subnet_name                   = optional(string)<br/>      subnet_id                     = optional(string)<br/>      private_ip_address            = optional(string)<br/>      private_ip_address_allocation = optional(string)<br/>      private_ip_address_version    = optional(string)<br/>      public_ip_name                = optional(string)<br/>      public_ip_id                  = optional(string)<br/>      public_ip_prefix_id           = optional(string)<br/>      zones                         = optional(list(string))<br/>    }))<br/>    backend_address_pools = optional(list(object({<br/>      name = string<br/>    })))<br/>    probes = optional(list(object({<br/>      name                = string<br/>      protocol            = string<br/>      port                = number<br/>      request_path        = optional(string)<br/>      interval_in_seconds = optional(number)<br/>      number_of_probes    = optional(number)<br/>    })))<br/>    rules = optional(list(object({<br/>      name                           = string<br/>      protocol                       = string<br/>      frontend_port                  = number<br/>      backend_port                   = number<br/>      frontend_ip_configuration_name = string<br/>      backend_address_pool_name      = optional(string)<br/>      probe_name                     = optional(string)<br/>      enable_floating_ip             = optional(bool)<br/>      idle_timeout_in_minutes        = optional(number)<br/>      load_distribution              = optional(string)<br/>      disable_outbound_snat          = optional(bool)<br/>      tcp_reset_enabled              = optional(bool)<br/>    })))<br/>  }))</pre> | `{}` | no |
| <a name="input_nat_gateways"></a> [nat\_gateways](#input\_nat\_gateways) | value to set the nat gateways | <pre>map(object({<br/>    nat_gateway_name        = string<br/>    resource_group_name     = optional(string)<br/>    location                = string<br/>    sku_name                = optional(string)<br/>    idle_timeout_in_minutes = optional(number)<br/>    public_ip_names         = optional(list(string))<br/>    public_ip_ids           = optional(list(string))<br/>    public_ip_prefix_ids    = optional(list(string))<br/>    tags                    = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_network_security_groups"></a> [network\_security\_groups](#input\_network\_security\_groups) | value to set the network security groups | <pre>map(object({<br/>    nsg_name            = string<br/>    resource_group_name = optional(string)<br/>    location            = string<br/>    security_rules = optional(list(object({<br/>      name                                       = string<br/>      priority                                   = number<br/>      direction                                  = string<br/>      access                                     = string<br/>      protocol                                   = string<br/>      source_port_range                          = optional(string)<br/>      source_port_ranges                         = optional(list(string))<br/>      destination_port_range                     = optional(string)<br/>      destination_port_ranges                    = optional(list(string))<br/>      source_address_prefix                      = optional(string)<br/>      source_address_prefixes                    = optional(list(string))<br/>      destination_address_prefix                 = optional(string)<br/>      destination_address_prefixes               = optional(list(string))<br/>      source_application_security_group_ids      = optional(list(string))<br/>      destination_application_security_group_ids = optional(list(string))<br/>      description                                = optional(string)<br/>    })))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_network_watchers"></a> [network\_watchers](#input\_network\_watchers) | value to set the network watchers | <pre>map(object({<br/>    network_watcher_name = string<br/>    resource_group_name  = optional(string)<br/>    location             = string<br/>    tags                 = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_private_dns_zone_virtual_network_links"></a> [private\_dns\_zone\_virtual\_network\_links](#input\_private\_dns\_zone\_virtual\_network\_links) | value to set the private dns zone virtual network links | <pre>map(object({<br/>    private_dns_zone_virtual_network_link_name = string<br/>    resource_group_name                        = optional(string)<br/>    private_dns_zone_name                      = optional(string)<br/>    virtual_network_name                       = optional(string)<br/>    virtual_network_id                         = optional(string)<br/>    registration_enabled                       = optional(bool)<br/>    tags                                       = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_private_dns_zones"></a> [private\_dns\_zones](#input\_private\_dns\_zones) | value to set the private dns zones | <pre>map(object({<br/>    private_dns_zone_name = string<br/>    resource_group_name   = optional(string)<br/>    tags                  = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | value to set the private endpoints | <pre>map(object({<br/>    private_endpoint_name           = string<br/>    resource_group_name             = optional(string)<br/>    location                        = string<br/>    subnet_name                     = optional(string)<br/>    subnet_id                       = optional(string)<br/>    custom_network_interface_name   = optional(string)<br/>    private_service_connection_name = optional(string)<br/>    private_connection_resource_id  = string<br/>    subresource_names               = list(string)<br/>    is_manual_connection            = optional(bool)<br/>    request_message                 = optional(string)<br/>    private_dns_zone_group_name     = optional(string)<br/>    private_dns_zone_names          = optional(list(string))<br/>    private_dns_zone_ids            = optional(list(string))<br/>    tags                            = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_public_ips"></a> [public\_ips](#input\_public\_ips) | value to set the public ips | <pre>map(object({<br/>    public_ip_name          = string<br/>    resource_group_name     = optional(string)<br/>    location                = string<br/>    allocation_method       = string<br/>    sku                     = optional(string)<br/>    sku_tier                = optional(string)<br/>    domain_name_label       = optional(string)<br/>    reverse_fqdn            = optional(string)<br/>    ip_version              = optional(string)<br/>    idle_timeout_in_minutes = optional(number)<br/>    zones                   = optional(list(string))<br/>    tags                    = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_resources_groups"></a> [resources\_groups](#input\_resources\_groups) | value to set the resources groups | <pre>map(object({<br/>    resource_group_name = string<br/>    location            = string<br/>    tags                = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | value to set the route tables | <pre>map(object({<br/>    route_table_name              = string<br/>    resource_group_name           = optional(string)<br/>    location                      = string<br/>    bgp_route_propagation_enabled = optional(bool)<br/>    routes = optional(list(object({<br/>      name                   = string<br/>      address_prefix         = string<br/>      next_hop_type          = string<br/>      next_hop_in_ip_address = optional(string)<br/>    })))<br/>    tags = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | value to set the subnets | <pre>map(object({<br/>    subnet_name                           = string<br/>    resource_group_name                   = optional(string)<br/>    virtual_network_name                  = optional(string)<br/>    address_prefixes                      = list(string)<br/>    service_endpoints                     = optional(list(string))<br/>    service_endpoint_policy_ids           = optional(list(string))<br/>    private_endpoint_network_policies     = optional(string)<br/>    private_link_service_network_policies = optional(bool)<br/>    delegations = optional(list(object({<br/>      name = string<br/>      service_delegation = object({<br/>        name    = string<br/>        actions = optional(list(string))<br/>      })<br/>    })))<br/>    nsg_name         = optional(string)<br/>    nsg_id           = optional(string)<br/>    route_table_name = optional(string)<br/>    route_table_id   = optional(string)<br/>    nat_gateway_name = optional(string)<br/>    nat_gateway_id   = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the global tags | `map(string)` | `{}` | no |
| <a name="input_virtual_network_peerings"></a> [virtual\_network\_peerings](#input\_virtual\_network\_peerings) | value to set the virtual network peerings | <pre>map(object({<br/>    peering_name                 = string<br/>    resource_group_name          = optional(string)<br/>    virtual_network_name         = optional(string)<br/>    remote_virtual_network_name  = optional(string)<br/>    remote_virtual_network_id    = optional(string)<br/>    allow_virtual_network_access = optional(bool)<br/>    allow_forwarded_traffic      = optional(bool)<br/>    allow_gateway_transit        = optional(bool)<br/>    use_remote_gateways          = optional(bool)<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | value to set the virtual networks | <pre>map(object({<br/>    virtual_network_name = string<br/>    resource_group_name  = optional(string)<br/>    location             = string<br/>    address_space        = list(string)<br/>    dns_servers          = optional(list(string))<br/>    tags                 = optional(map(string))<br/>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->