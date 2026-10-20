# Azure Application Gateway Terraform Module

This module creates an Azure Application Gateway with support for WAF, SSL termination, path-based routing, and multi-site hosting.

## Features

- Standard_v2 and WAF_v2 SKU support
- Autoscaling configuration
- Zone redundancy
- WAF with OWASP rule sets
- SSL/TLS termination with Key Vault integration
- Health probes
- Path-based and multi-site routing
- Private frontend IP support
- Diagnostic settings

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Subnet | **Yes** | Dedicated subnet (minimum /26) |
| Public IP | No | Created automatically if not provided |
| Key Vault | No | For SSL certificates |
| WAF Policy | No | Alternative to inline waf_configuration |

## Usage

### Basic HTTP Application Gateway

```hcl
module "appgw" {
  source = "../../Networking/ApplicationGateway"

  resource_group_name = "rg-appgw-prod-001"
  location            = "westeurope"
  subnet_id           = module.subnet_appgw.id

  name = "agw-web-prod-001"

  sku = {
    name = "Standard_v2"
    tier = "Standard_v2"
  }

  autoscale_configuration = {
    min_capacity = 1
    max_capacity = 10
  }

  backend_address_pools = {
    "pool-web" = {
      ip_addresses = ["10.0.1.10", "10.0.1.11"]
    }
  }

  backend_http_settings = {
    "http-settings-web" = {
      port     = 80
      protocol = "Http"
    }
  }

  http_listeners = {
    "listener-http" = {
      frontend_port_name = "http"
      protocol           = "Http"
    }
  }

  request_routing_rules = {
    "rule-basic" = {
      rule_type                  = "Basic"
      priority                   = 100
      http_listener_name         = "listener-http"
      backend_address_pool_name  = "pool-web"
      backend_http_settings_name = "http-settings-web"
    }
  }
}
```

### WAF with HTTPS

```hcl
module "appgw_waf" {
  source = "../../Networking/ApplicationGateway"

  resource_group_name = "rg-appgw-prod-001"
  location            = "westeurope"
  subnet_id           = module.subnet_appgw.id
  name                = "agw-web-prod-001"

  sku = {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  waf_configuration = {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }

  ssl_certificates = {
    "cert-web" = {
      key_vault_secret_id = "https://kv-xxx.vault.azure.net/secrets/cert-web"
    }
  }

  identity = {
    identity_ids = [azurerm_user_assigned_identity.agw.id]
  }

  # ... listeners, backends, rules
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| subnet_id | Subnet ID | `string` | n/a | **yes** |
| name | Gateway name | `string` | auto | no |
| sku | SKU configuration | `object({...})` | Standard_v2 | no |
| autoscale_configuration | Autoscale config | `object({...})` | `null` | no |
| backend_address_pools | Backend pools | `map(object({...}))` | n/a | **yes** |
| backend_http_settings | HTTP settings | `map(object({...}))` | n/a | **yes** |
| http_listeners | Listeners | `map(object({...}))` | n/a | **yes** |
| request_routing_rules | Routing rules | `map(object({...}))` | n/a | **yes** |
| waf_configuration | WAF config | `object({...})` | `null` | no |
| ssl_certificates | SSL certs | `map(object({...}))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Gateway ID |
| name | Gateway name |
| public_ip_address | Public IP |
| backend_address_pools | Backend pool IDs |

## Security Recommendations

1. **Use WAF_v2** with Prevention mode for production
2. **Enable HTTPS** with TLS 1.2+ only
3. **Use Key Vault** for SSL certificate management
4. **Enable diagnostics** for monitoring and auditing
