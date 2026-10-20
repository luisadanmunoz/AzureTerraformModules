# Azure Load Balancer Terraform Module

This module creates an Azure Load Balancer (Standard or Basic) with support for public and internal configurations, backend pools, health probes, and load balancing rules.

## Features

- Public and Internal Load Balancer support
- Standard and Basic SKU
- Zone redundancy (Standard SKU)
- Backend address pools
- Health probes (TCP, HTTP, HTTPS)
- Load balancing rules
- Inbound NAT rules
- Outbound rules (Standard SKU)
- Diagnostic settings

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Public IP | No | For public LB (can be provided or created externally) |
| Subnet | No | For internal LB |
| Virtual Network | No | For IP-based backend pools |

## Usage

### Public Load Balancer

```hcl
module "lb_public" {
  source = "../../Networking/LoadBalancer"

  resource_group_name = "rg-lb-prod-001"
  location            = "westeurope"
  name                = "lb-web-prod-001"
  type                = "public"

  frontend_ip_configurations = {
    "frontend-public" = {
      public_ip_address_id = azurerm_public_ip.lb.id
      zones                = ["1", "2", "3"]
    }
  }

  backend_address_pools = {
    "pool-web" = {}
  }

  probes = {
    "probe-http" = {
      protocol     = "Http"
      port         = 80
      request_path = "/health"
    }
  }

  lb_rules = {
    "rule-http" = {
      frontend_ip_configuration_name = "frontend-public"
      backend_address_pool_names     = ["pool-web"]
      probe_name                     = "probe-http"
      protocol                       = "Tcp"
      frontend_port                  = 80
      backend_port                   = 80
    }
  }
}
```

### Internal Load Balancer

```hcl
module "lb_internal" {
  source = "../../Networking/LoadBalancer"

  resource_group_name = "rg-lb-prod-001"
  location            = "westeurope"
  name                = "lb-app-prod-001"
  type                = "internal"

  frontend_ip_configurations = {
    "frontend-internal" = {
      subnet_id          = module.subnet.id
      private_ip_address = "10.0.1.100"
      private_ip_address_allocation = "Static"
    }
  }

  backend_address_pools = {
    "pool-app" = {}
  }

  probes = {
    "probe-tcp" = {
      protocol = "Tcp"
      port     = 8080
    }
  }

  lb_rules = {
    "rule-app" = {
      frontend_ip_configuration_name = "frontend-internal"
      backend_address_pool_names     = ["pool-app"]
      probe_name                     = "probe-tcp"
      protocol                       = "Tcp"
      frontend_port                  = 8080
      backend_port                   = 8080
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | LB name | `string` | auto | no |
| sku | Basic, Standard, Gateway | `string` | `"Standard"` | no |
| type | public or internal | `string` | `"public"` | no |
| frontend_ip_configurations | Frontend configs | `map(object({...}))` | n/a | **yes** |
| backend_address_pools | Backend pools | `map(object({...}))` | `{}` | no |
| probes | Health probes | `map(object({...}))` | `{}` | no |
| lb_rules | LB rules | `map(object({...}))` | `{}` | no |
| nat_rules | NAT rules | `map(object({...}))` | `{}` | no |
| outbound_rules | Outbound rules | `map(object({...}))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Load Balancer ID |
| name | Load Balancer name |
| frontend_ip_configuration | Frontend configs |
| private_ip_address | Private IP (internal) |
| backend_address_pool_ids | Backend pool IDs |
| probe_ids | Probe IDs |
| lb_rule_ids | Rule IDs |
