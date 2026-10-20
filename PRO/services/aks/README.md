# Terraform Azure Kubernetes Service (AKS) Module

Este módulo de Terraform crea un clúster de Azure Kubernetes Service (AKS) con configuración de red privada, Application Gateway integrado, y permisos IAM apropiados.

## 🚀 Características

- **Clúster AKS privado** con DNS privado
- **Application Gateway** integrado para ingress
- **Identidad User-Assigned** para gestión de recursos
- **Red privada** con kubenet y Calico network policy
- **Permisos IAM** automáticos para DNS y red
- **Configuración de red** optimizada para producción

## 📦 Requisitos

- Terraform >= 1.0
- Azure Provider >= 3.0
- Resource Group existente
- VNet y subnet configurados
- User-Assigned Identity creada
- Application Gateway existente
- Private DNS Zone configurada

## 🔧 Variables de Entrada

| Nombre | Descripción | Tipo | Por Defecto | Obligatorio |
|--------|-------------|------|-------------|-------------|
| `name` | Nombre del clúster AKS | `string` | - | ✅ |
| `location` | Región de Azure para el clúster | `string` | - | ✅ |
| `resource_group_name` | Nombre del grupo de recursos | `string` | - | ✅ |
| `node_resource_group` | Grupo de recursos para nodos | `string` | - | ✅ |
| `dns_prefix_private_cluster` | Prefijo DNS para clúster privado | `string` | - | ✅ |
| `private_dns_zone_id` | ID de la zona DNS privada | `string` | - | ✅ |
| `identity_ids` | IDs de identidades User-Assigned | `set(string)` | - | ✅ |
| `vnet_subnet_id` | ID de la subnet para nodos | `string` | - | ✅ |
| `gateway_id` | ID del Application Gateway | `string` | - | ✅ |
| `scope_dns` | Scope para permisos DNS | `string` | - | ✅ |
| `principal_id_identity` | Principal ID de la identidad | `string` | - | ✅ |
| `scope_rg` | Scope para permisos de red | `string` | - | ✅ |
| `tags` | Etiquetas para recursos | `map(any)` | `{}` | ❌ |

## 📤 Outputs

Este módulo no define outputs específicos, pero el clúster AKS creado puede ser referenciado usando:

```hcl
# Acceder al clúster
data "azurerm_kubernetes_cluster" "cluster" {
  name                = module.aks.name
  resource_group_name = var.resource_group_name
}
```

## 🏗️ Recursos Creados

- **azurerm_kubernetes_cluster** - Clúster AKS con configuración privada
- **azurerm_role_assignment** - Permisos DNS Zone Contributor
- **azurerm_role_assignment** - Permisos Network Contributor

## 📘 Ejemplo de Uso

### Configuración Completa
```hcl
# Crear User-Assigned Identity
resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "aks-identity"
  location            = "East US"
  resource_group_name = "rg-production"
}

# Crear Private DNS Zone
resource "azurerm_private_dns_zone" "aks_dns" {
  name                = "privatelink.eastus.azmk8s.io"
  resource_group_name = "rg-production"
}

# Crear Application Gateway
resource "azurerm_application_gateway" "agw" {
  name                = "aks-agw"
  resource_group_name = "rg-production"
  location            = "East US"
  # ... configuración del gateway
}

# Crear AKS
module "aks" {
  source = "./modules/aks"
  
  name                        = "production-aks"
  location                    = "East US"
  resource_group_name         = "rg-production"
  node_resource_group         = "rg-aks-nodes"
  dns_prefix_private_cluster  = "prodaks"
  private_dns_zone_id         = azurerm_private_dns_zone.aks_dns.id
  identity_ids                = [azurerm_user_assigned_identity.aks_identity.id]
  vnet_subnet_id              = azurerm_subnet.aks_subnet.id
  gateway_id                  = azurerm_application_gateway.agw.id
  scope_dns                   = azurerm_private_dns_zone.aks_dns.id
  principal_id_identity       = azurerm_user_assigned_identity.aks_identity.principal_id
  scope_rg                    = azurerm_resource_group.production.id
  
  tags = {
    Environment = "production"
    Owner       = "platform-team"
    Project     = "kubernetes"
  }
}
```

### Configuración Mínima
```hcl
module "aks" {
  source = "./modules/aks"
  
  name                        = "dev-aks"
  location                    = "West Europe"
  resource_group_name         = "rg-development"
  node_resource_group         = "rg-aks-nodes-dev"
  dns_prefix_private_cluster  = "devaks"
  private_dns_zone_id         = var.private_dns_zone_id
  identity_ids                = [var.identity_id]
  vnet_subnet_id              = var.aks_subnet_id
  gateway_id                  = var.gateway_id
  scope_dns                   = var.dns_zone_scope
  principal_id_identity       = var.principal_id
  scope_rg                    = var.resource_group_scope
}
```

## 🌐 Configuración de Red

### Configuración Actual del Módulo
```hcl
network_profile {
  network_plugin = "kubenet"        # Plugin de red
  network_policy = "calico"         # Política de red
  dns_service_ip = "10.52.4.100"   # IP del servicio DNS
  service_cidr   = "10.52.4.0/24"  # CIDR para servicios
  pod_cidrs      = ["10.53.0.0/22"] # CIDR para pods
}
```

### Rangos de IP Recomendados

#### Desarrollo
```hcl
dns_service_ip = "10.1.4.100"
service_cidr   = "10.1.4.0/24"
pod_cidrs      = ["10.1.5.0/22"]
```

#### Staging
```hcl
dns_service_ip = "10.2.4.100"
service_cidr   = "10.2.4.0/24"
pod_cidrs      = ["10.2.5.0/22"]
```

#### Producción
```hcl
dns_service_ip = "10.0.4.100"
service_cidr   = "10.0.4.0/24"
pod_cidrs      = ["10.0.5.0/22"]
```

## 🔐 Seguridad y Permisos

### Permisos IAM Configurados
- **DNS Zone Contributor**: Para gestionar registros DNS privados
- **Network Contributor**: Para gestionar recursos de red

### Configuración de Seguridad
- **Clúster privado**: API server no accesible desde internet
- **Network Policy**: Calico para control de tráfico entre pods
- **User-Assigned Identity**: Sin claves de acceso almacenadas

## 🚀 Configuración Avanzada

### Con Múltiples Node Pools
```hcl
# El módulo actual solo crea el default node pool
# Para pools adicionales, crear recursos separados:

resource "azurerm_kubernetes_cluster_node_pool" "gpu_pool" {
  name                  = "gpunodes"
  kubernetes_cluster_id = module.aks.id
  vm_size              = "Standard_NC6s_v3"
  node_count           = 2
  
  node_taints = ["sku=gpu:NoSchedule"]
}
```

### Con Azure Monitor
```hcl
# Habilitar Azure Monitor para contenedores
resource "azurerm_monitor_diagnostic_setting" "aks_diagnostics" {
  name                       = "aks-diagnostics"
  target_resource_id         = module.aks.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "kube-apiserver"
  }

  metric {
    category = "AllMetrics"
  }
}
```

### Con Azure Policy
```hcl
# Aplicar políticas de seguridad
resource "azurerm_kubernetes_cluster_extension" "azure_policy" {
  name           = "azure-policy"
  cluster_id     = module.aks.id
  extension_type = "microsoft.azurepolicy"
}
```

## 📊 Monitoreo y Observabilidad

### Configuración de Logs
```hcl
# El clúster incluye logging básico
# Para logging avanzado, configurar:

resource "azurerm_kubernetes_cluster_extension" "prometheus" {
  name           = "prometheus"
  cluster_id     = module.aks.id
  extension_type = "microsoft.azuremonitor.containers.insights"
}
```

### Métricas Importantes
- **CPU y memoria** de nodos y pods
- **Network** throughput y latencia
- **Storage** IOPS y throughput
- **Application** response times

## 🔧 Troubleshooting

### Problemas Comunes

1. **Clúster no se puede conectar**
   - Verificar configuración de DNS privado
   - Comprobar conectividad de red
   - Revisar permisos IAM

2. **Application Gateway no funciona**
   - Verificar integración con AKS
   - Comprobar configuración de ingress
   - Revisar health probes

3. **Pods no pueden comunicarse**
   - Verificar Network Policy de Calico
   - Comprobar configuración de red
   - Revisar security groups

### Comandos Útiles
```bash
# Conectar al clúster
az aks get-credentials --resource-group rg-production --name production-aks

# Ver nodos
kubectl get nodes

# Ver pods del sistema
kubectl get pods -n kube-system

# Ver logs del API server
kubectl logs -n kube-system deployment/coredns

# Verificar conectividad de red
kubectl run test-pod --image=busybox --rm -it -- nslookup kubernetes.default
```

## 🚀 Mejores Prácticas

### Naming Convention
```hcl
name = "${var.environment}-${var.project}-aks"
# Ejemplo: "prod-ecommerce-aks"
```

### Etiquetado Consistente
```hcl
tags = {
  Environment   = var.environment
  Project       = var.project_name
  Owner         = var.owner
  CostCenter    = var.cost_center
  Kubernetes    = "aks"
  NetworkPolicy = "calico"
}
```

### Configuración de Nodos
```hcl
# El módulo usa configuración básica
# Para producción, considerar:
# - VM sizes más grandes (Standard_D4s_v3)
# - Múltiples availability zones
# - Auto-scaling habilitado
```

## 🔄 Lifecycle Management

### Actualizaciones de Kubernetes
```bash
# Ver versiones disponibles
az aks get-upgrades --resource-group rg-production --name production-aks

# Actualizar clúster
az aks upgrade --resource-group rg-production --name production-aks --kubernetes-version 1.28.0
```

### Backup y Recovery
- **Estado de aplicaciones**: Usar Velero para backup de Kubernetes
- **Configuración**: Mantener en Git con GitOps
- **Datos persistentes**: Backup de volúmenes Azure Disk

## 📋 Requisitos del Sistema

- **Terraform** >= 1.0
- **Azure Provider** >= 3.0
- **kubectl** instalado
- **az CLI** configurado
- **Permisos Azure**: Contributor en Resource Group
- **Quota suficiente** para recursos AKS

## 📞 Soporte

Para problemas o preguntas:
1. Revisa los logs de Azure Monitor
2. Verifica la configuración de red
3. Comprueba los permisos IAM
4. Consulta la documentación de Azure AKS
5. Contacta al equipo de Platform/DevOps
