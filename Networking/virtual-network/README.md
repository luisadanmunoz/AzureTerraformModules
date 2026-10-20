# Azure Virtual Network Module

Modulo de Terraform para crear Virtual Networks en Azure con soporte para DNS personalizado, DDoS Protection y configuracion de diagnosticos.

## Uso Basico

```hcl
module "vnet" {
  source = "../../modules/virtual-network"

  name                = "vnet-mi-proyecto-dev"
  resource_group_name = "rg-mi-proyecto-dev"
  location            = "westeurope"
  address_space       = ["10.0.0.0/16"]
}
```

## Uso con DNS Personalizado

```hcl
module "vnet" {
  source = "../../modules/virtual-network"

  name                = "vnet-corporativa-prod"
  resource_group_name = "rg-networking-prod"
  location            = "westeurope"
  address_space       = ["10.0.0.0/16", "172.16.0.0/16"]

  # Servidores DNS personalizados (ej: Active Directory)
  dns_servers = [
    "10.0.0.4",   # DC primario
    "10.0.0.5",   # DC secundario
    "168.63.129.16"  # Azure DNS (fallback)
  ]

  tags = {
    Environment = "production"
    NetworkType = "hub"
  }
}
```

## Uso con DDoS Protection

```hcl
# Primero crear el DDoS Protection Plan
resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = "ddos-plan-prod"
  location            = "westeurope"
  resource_group_name = "rg-security-prod"
}

# Luego asociar a la VNet
module "vnet" {
  source = "../../modules/virtual-network"

  name                    = "vnet-critica-prod"
  resource_group_name     = "rg-networking-prod"
  location                = "westeurope"
  address_space           = ["10.0.0.0/16"]
  ddos_protection_plan_id = azurerm_network_ddos_protection_plan.ddos.id

  tags = {
    Environment  = "production"
    SecurityTier = "high"
  }
}
```

## Uso con Diagnosticos (Log Analytics)

```hcl
module "vnet" {
  source = "../../modules/virtual-network"

  name                       = "vnet-monitoreada-dev"
  resource_group_name        = "rg-mi-proyecto-dev"
  location                   = "westeurope"
  address_space              = ["10.0.0.0/16"]
  log_analytics_workspace_id = module.log_analytics.id

  tags = {
    Environment = "development"
    Monitoring  = "enabled"
  }
}
```

## Arquitectura de Referencia

```
┌─────────────────────────────────────────────────────────────┐
│                    Virtual Network                          │
│                    10.0.0.0/16                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐  │
│  │   Subnet Web    │  │  Subnet App     │  │ Subnet DB   │  │
│  │  10.0.1.0/24    │  │  10.0.2.0/24    │  │ 10.0.3.0/24 │  │
│  │                 │  │                 │  │             │  │
│  │  ┌───┐ ┌───┐    │  │  ┌───┐ ┌───┐    │  │  ┌───┐      │  │
│  │  │VM │ │VM │    │  │  │VM │ │VM │    │  │  │SQL│      │  │
│  │  └───┘ └───┘    │  │  └───┘ └───┘    │  │  └───┘      │  │
│  └─────────────────┘  └─────────────────┘  └─────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

## Inputs

| Nombre | Descripcion | Tipo | Default | Requerido |
|--------|-------------|------|---------|-----------|
| `name` | Nombre de la VNet (2-64 caracteres) | `string` | - | Si |
| `resource_group_name` | Nombre del Resource Group | `string` | - | Si |
| `location` | Region de Azure | `string` | - | Si |
| `address_space` | Lista de rangos CIDR | `list(string)` | `["10.0.0.0/16"]` | No |
| `dns_servers` | Servidores DNS personalizados | `list(string)` | `[]` | No |
| `ddos_protection_plan_id` | ID del DDoS Protection Plan | `string` | `null` | No |
| `log_analytics_workspace_id` | ID del Log Analytics para diagnosticos | `string` | `null` | No |
| `tags` | Tags adicionales | `map(string)` | `{}` | No |
| `default_tags` | Tags por defecto | `map(string)` | `{ManagedBy = "Terraform"}` | No |

## Outputs

| Nombre | Descripcion |
|--------|-------------|
| `id` | ID de la Virtual Network |
| `name` | Nombre de la Virtual Network |
| `address_space` | Espacio de direcciones configurado |
| `guid` | GUID unico de la VNet |
| `location` | Region de la VNet |
| `resource_group_name` | Resource Group de la VNet |

## Planificacion del Espacio de Direcciones

### Recomendaciones de CIDR

| Tamano de Red | CIDR | Hosts Disponibles | Caso de Uso |
|---------------|------|-------------------|-------------|
| Pequena | /24 | 251 | Entorno de desarrollo |
| Mediana | /20 | 4,091 | Aplicacion individual |
| Grande | /16 | 65,531 | Multiples aplicaciones |
| Enterprise | /8 | 16,777,211 | Organizacion completa |

### Esquema de Subnets Recomendado

```hcl
# Para una VNet 10.0.0.0/16
address_space = ["10.0.0.0/16"]

# Subnets recomendadas:
# 10.0.0.0/24   - GatewaySubnet (VPN/ExpressRoute)
# 10.0.1.0/24   - AzureFirewallSubnet
# 10.0.2.0/24   - AzureBastionSubnet
# 10.0.10.0/24  - Web Tier
# 10.0.20.0/24  - Application Tier
# 10.0.30.0/24  - Database Tier
# 10.0.100.0/24 - Management
```

## Notas Importantes

### Servidores DNS
- Si no se especifican, Azure usa DNS por defecto (168.63.129.16)
- Los cambios de DNS requieren reiniciar las VMs para aplicarse
- Siempre incluir Azure DNS como fallback

### DDoS Protection
- **Standard**: Proteccion avanzada con metricas y alertas
- **Basic**: Incluido por defecto, proteccion a nivel de plataforma
- El plan DDoS tiene un costo fijo mensual significativo

### Diagnosticos
Los logs disponibles incluyen:
- `VMProtectionAlerts` - Alertas de proteccion de VMs

### Peering
Esta VNet puede conectarse con otras mediante:
- VNet Peering (misma region o global)
- VPN Gateway
- ExpressRoute

## Recursos Creados

- `azurerm_virtual_network.this` - La Virtual Network
- `azurerm_monitor_diagnostic_setting.this` - Configuracion de diagnosticos (opcional)

## Ejemplo Completo con Subnets

```hcl
# Resource Group
module "rg" {
  source   = "../../modules/resource-group"
  name     = "rg-networking-dev"
  location = "westeurope"
}

# Virtual Network
module "vnet" {
  source = "../../modules/virtual-network"

  name                = "vnet-hub-dev"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "168.63.129.16"]

  tags = {
    Environment = "development"
    Topology    = "hub-spoke"
  }
}

# Subnet para Web
module "subnet_web" {
  source = "../../modules/subnet"

  name                 = "snet-web-dev"
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
  address_prefixes     = ["10.0.10.0/24"]
}

# Subnet para Base de Datos
module "subnet_db" {
  source = "../../modules/subnet"

  name                 = "snet-db-dev"
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
  address_prefixes     = ["10.0.30.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
}
```

<!-- BEGIN_TF_DOCS -->
# Azure Virtual Network Module

Modulo reutilizable para crear Virtual Networks en Azure.
Soporta DNS personalizado, DDoS protection y peering.

## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Espacio de direcciones CIDR para la VNet | `list(string)` | <pre>[<br/>  "10.0.0.0/16"<br/>]</pre> | no |
| <a name="input_ddos_protection_plan_id"></a> [ddos\_protection\_plan\_id](#input\_ddos\_protection\_plan\_id) | ID del DDoS Protection Plan (opcional) | `string` | `null` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags por defecto | `map(string)` | <pre>{<br/>  "ManagedBy": "Terraform"<br/>}</pre> | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Lista de servidores DNS personalizados | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Region de Azure | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | ID del Log Analytics Workspace para diagnosticos | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Nombre de la Virtual Network | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nombre del Resource Group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags adicionales | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_address_space"></a> [address\_space](#output\_address\_space) | Espacio de direcciones de la VNet |
| <a name="output_guid"></a> [guid](#output\_guid) | GUID de la Virtual Network |
| <a name="output_id"></a> [id](#output\_id) | ID de la Virtual Network |
| <a name="output_location"></a> [location](#output\_location) | Ubicacion de la VNet |
| <a name="output_name"></a> [name](#output\_name) | Nombre de la Virtual Network |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource Group de la VNet |
<!-- END_TF_DOCS -->