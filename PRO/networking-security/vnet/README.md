# Terraform Azure Virtual Network (VNet) Module

Este módulo de Terraform crea una red virtual (VNet) en Azure con configuraciones personalizables de espacio de direcciones y servidores DNS.

## 🚀 Características

- **Red Virtual** con espacio de direcciones personalizable
- **Servidores DNS** configurables
- **Etiquetas** para organización y gestión
- **Outputs útiles** para integración con otros recursos
- **Configuración flexible** para diferentes entornos

## 📦 Requisitos

- Terraform >= 1.0
- Azure Provider >= 3.0
- Resource Group existente
- Permisos para crear recursos de red

## 🔧 Variables de Entrada

| Nombre | Descripción | Tipo | Por Defecto | Obligatorio |
|--------|-------------|------|-------------|-------------|
| `name` | Nombre de la red virtual | `string` | - | ✅ |
| `location` | Región de Azure donde crear la VNet | `string` | - | ✅ |
| `resource_group_name` | Nombre del grupo de recursos | `string` | - | ✅ |
| `address_space` | Lista de rangos CIDR para la VNet | `list(string)` | - | ✅ |
| `dns_servers` | Lista de servidores DNS personalizados | `list(string)` | - | ❌ |
| `tags` | Etiquetas para el recurso | `map(any)` | `{}` | ❌ |

## 📤 Outputs

| Nombre | Descripción |
|--------|-------------|
| `id` | ID único de la red virtual |
| `name` | Nombre de la red virtual |

## 🏗️ Recursos Creados

- **azurerm_virtual_network** - Red virtual con la configuración especificada

## 📘 Ejemplo de Uso

### Uso Básico
```hcl
module "vnet" {
  source = "./modules/vnet"
  
  name                = "production-vnet"
  location            = "East US"
  resource_group_name = "rg-production"
  address_space       = ["10.0.0.0/16"]
  
  tags = {
    Environment = "production"
    Owner       = "networking-team"
    Project     = "ecommerce"
  }
}
```

### Con DNS Personalizado
```hcl
module "vnet" {
  source = "./modules/vnet"
  
  name                = "development-vnet"
  location            = "West Europe"
  resource_group_name = "rg-development"
  address_space       = ["172.16.0.0/16"]
  dns_servers         = ["8.8.8.8", "8.8.4.4", "1.1.1.1"]
  
  tags = {
    Environment = "development"
    Owner       = "dev-team"
    CostCenter  = "engineering"
  }
}
```

### Múltiples Espacios de Direcciones
```hcl
module "vnet" {
  source = "./modules/vnet"
  
  name                = "multi-cidr-vnet"
  location            = "Central US"
  resource_group_name = "rg-multi-cidr"
  address_space       = ["10.0.0.0/16", "192.168.0.0/16"]
  
  tags = {
    Environment = "staging"
    Purpose     = "multi-tenant"
  }
}
```

## 🌐 Configuración de Red

### Espacios de Direcciones Recomendados

#### Desarrollo
```hcl
address_space = ["10.1.0.0/16"]  # 65,534 hosts
```

#### Staging
```hcl
address_space = ["10.2.0.0/16"]  # 65,534 hosts
```

#### Producción
```hcl
address_space = ["10.0.0.0/16"]  # 65,534 hosts
```

#### Multi-tenant
```hcl
address_space = ["10.0.0.0/16", "172.16.0.0/16"]  # Múltiples rangos
```

### Servidores DNS

#### DNS Público (Google/Cloudflare)
```hcl
dns_servers = ["8.8.8.8", "8.8.4.4"]        # Google DNS
dns_servers = ["1.1.1.1", "1.0.0.1"]        # Cloudflare DNS
```

#### DNS Corporativo
```hcl
dns_servers = ["10.0.0.10", "10.0.0.11"]    # DNS interno
```

#### DNS de Azure (por defecto)
```hcl
dns_servers = []  # Usa DNS de Azure automáticamente
```

## 🔧 Configuración Avanzada

### Con Subnets (usando módulo separado)
```hcl
# Crear VNet
module "vnet" {
  source = "./modules/vnet"
  
  name                = "production-vnet"
  location            = "East US"
  resource_group_name = "rg-production"
  address_space       = ["10.0.0.0/16"]
}

# Crear subnets
module "subnet" {
  source = "./modules/subnet"
  
  name                 = "web-subnet"
  resource_group_name  = "rg-production"
  virtual_network_name = module.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
```

### Con Network Security Groups
```hcl
# Crear VNet
module "vnet" {
  source = "./modules/vnet"
  # ... configuración
}

# Crear NSG
resource "azurerm_network_security_group" "web_nsg" {
  name                = "web-nsg"
  location            = "East US"
  resource_group_name = "rg-production"
  
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  tags = {
    Environment = "production"
  }
}
```

## 🏷️ Etiquetado Consistente

### Estructura de Tags Recomendada
```hcl
tags = {
  Environment   = var.environment      # dev, staging, prod
  Project       = var.project_name     # nombre del proyecto
  Owner         = var.owner            # equipo responsable
  CostCenter    = var.cost_center      # centro de costos
  CreatedBy     = "terraform"          # herramienta de creación
  CreatedDate   = timestamp()          # fecha de creación
  Backup        = "daily"              # política de backup
  Monitoring    = "enabled"            # monitoreo habilitado
}
```

### Variables para Tags
```hcl
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "owner" {
  description = "Team or person responsible"
  type        = string
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
}
```

## 🔐 Seguridad

### Mejores Prácticas de Seguridad

1. **Espacios de Direcciones Privadas**
   - Usar rangos RFC 1918 (10.x.x.x, 172.16-31.x.x, 192.168.x.x)
   - Evitar solapamientos con redes existentes

2. **DNS Seguro**
   - Usar DNS corporativo cuando sea posible
   - Considerar DNS over HTTPS para mayor seguridad

3. **Etiquetado de Seguridad**
   ```hcl
   tags = {
     SecurityLevel = "high"
     DataClass     = "confidential"
     Compliance    = "PCI-DSS"
   }
   ```

## 📊 Monitoreo y Logging

### Diagnostic Settings
```hcl
resource "azurerm_monitor_diagnostic_setting" "vnet_diagnostics" {
  name                       = "vnet-diagnostics"
  target_resource_id         = module.vnet.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "VMProtectionAlerts"
  }

  metric {
    category = "AllMetrics"
  }
}
```

### Network Watcher
```hcl
resource "azurerm_network_watcher" "main" {
  name                = "NetworkWatcher_${var.location}"
  location            = var.location
  resource_group_name = var.resource_group_name
}
```

## 🚀 Mejores Prácticas

### Naming Convention
```hcl
# Formato: {environment}-{project}-{region}-vnet
name = "${var.environment}-${var.project}-${var.location_short}-vnet"
# Ejemplo: "prod-ecommerce-eus-vnet"
```

### Múltiples VNets por Entorno
```hcl
# VNet para aplicaciones web
module "web_vnet" {
  source = "./modules/vnet"
  name   = "web-vnet"
  # ... configuración específica para web
}

# VNet para bases de datos
module "db_vnet" {
  source = "./modules/vnet"
  name   = "db-vnet"
  # ... configuración específica para DB
}
```

### Peering entre VNets
```hcl
# Crear peering entre VNets
resource "azurerm_virtual_network_peering" "web_to_db" {
  name                      = "web-to-db-peering"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = module.web_vnet.name
  remote_virtual_network_id = module.db_vnet.id
}
```

## 🔄 Lifecycle Management

### Backup y Recovery
```hcl
# Las VNets se pueden recrear fácilmente
# Considera usar Terraform state backup
# Implementa políticas de retención para recursos relacionados
```

### Actualizaciones
```hcl
# Para cambiar el espacio de direcciones:
# 1. Crear nueva VNet con nuevo CIDR
# 2. Migrar recursos gradualmente
# 3. Eliminar VNet antigua
```

## 🚨 Troubleshooting

### Problemas Comunes

1. **Espacio de direcciones solapado**
   - Verificar que no haya conflictos con otras VNets
   - Usar calculadora de subnets para planificar

2. **DNS no funciona**
   - Verificar configuración de DNS servers
   - Comprobar conectividad de red

3. **Recursos no pueden conectarse**
   - Verificar que estén en la misma VNet
   - Revisar Network Security Groups

### Comandos Útiles
```bash
# Ver detalles de la VNet
az network vnet show --name production-vnet --resource-group rg-production

# Listar subnets
az network vnet subnet list --vnet-name production-vnet --resource-group rg-production

# Verificar conectividad
az network watcher test-connectivity --resource-group rg-production --source-resource vm1 --dest-resource vm2
```

## 📋 Requisitos del Sistema

- **Terraform** >= 1.0
- **Azure Provider** >= 3.0
- **Permisos Azure**: Contributor en el Resource Group
- **Resource Group** existente
- **Suscripción Azure** activa

## 📞 Soporte

Para problemas o preguntas:
1. Revisa los logs de Azure Monitor
2. Verifica la configuración de DNS
3. Comprueba los Network Security Groups
4. Consulta la documentación de Azure VNet
5. Contacta al equipo de Networking