# Terraform Azure NetApp Cloud Manager Deployment Module

Este módulo de Terraform despliega un Cloud Manager Connector de NetApp en Azure con todos los permisos y configuraciones necesarias.

## 🚀 Características

- **Cloud Manager Connector** de NetApp en Azure
- **Rol personalizado** con permisos específicos para NetApp
- **Network Security Group** configurado para conectividad
- **Asignación automática** de permisos IAM
- **Integración** con Azure NetApp Files

## 📦 Requisitos

- Terraform >= 1.0
- Azure Provider >= 2.46.0
- NetApp Cloud Manager Provider
- Token de NetApp Cloud Manager

## 🔧 Variables de Entrada

| Nombre | Descripción | Tipo | Por Defecto | Obligatorio |
|--------|-------------|------|-------------|-------------|
| `token` | Token de NetApp Cloud Manager | `string` | - | ✅ |
| `subscription_id` | ID de la suscripción Azure | `string` | - | ✅ |
| `location` | Región de Azure | `string` | - | ✅ |
| `resource_group` | Grupo de recursos | `string` | - | ✅ |
| `company` | Nombre de la empresa | `string` | - | ✅ |
| `subnet_name` | ID de la subnet | `string` | - | ✅ |
| `vnet_name` | ID de la VNet | `string` | - | ✅ |
| `publicIP` | Asociar IP pública | `bool` | - | ✅ |
| `admin_password` | Contraseña del administrador | `string` | - | ✅ |
| `admin_username` | Usuario administrador | `string` | - | ✅ |

## 📤 Outputs

| Nombre | Descripción |
|--------|-------------|
| `current_subscription_display_name` | Nombre de la suscripción actual |
| `current_subscription_display_id` | ID de la suscripción actual |

## 📘 Ejemplo de Uso

```hcl
module "netapp_cloud_manager" {
  source = "./modules/cloudmanagerdeployment"

  token           = var.netapp_token
  subscription_id = var.subscription_id
  location        = "East US"
  resource_group  = "rg-netapp"
  company         = "MyCompany"
  subnet_name     = "/subscriptions/.../resourceGroups/rg-netapp/providers/Microsoft.Network/virtualNetworks/vnet-netapp/subnets/subnet-netapp"
  vnet_name       = "/subscriptions/.../resourceGroups/rg-netapp/providers/Microsoft.Network/virtualNetworks/vnet-netapp"
  publicIP        = true
  admin_password  = var.admin_password
  admin_username  = "netappadmin"
}
```

## 🏗️ Recursos Creados

- **azurerm_role_definition** - Rol personalizado para Cloud Manager
- **azurerm_network_security_group** - NSG con reglas de conectividad
- **netapp-cloudmanager_connector_azure** - Cloud Manager Connector
- **azurerm_role_assignment** - Asignación de permisos

## 🔐 Permisos IAM

El módulo crea un rol personalizado con permisos para:
- **Compute**: Gestión de VMs, discos, imágenes
- **Network**: Gestión de VNets, subnets, NSGs, load balancers
- **Storage**: Gestión de storage accounts
- **NetApp**: Gestión completa de Azure NetApp Files
- **Resources**: Gestión de resource groups y deployments

## 🌐 Configuración de Red

### Security Group Rules
- **HTTP (80)**: Acceso web
- **HTTPS (443)**: Acceso seguro
- **SSH (22)**: Acceso administrativo
- **Outbound**: Conectividad completa a internet

## ⚠️ Notas Importantes

- Requiere token válido de NetApp Cloud Manager
- El rol personalizado tiene permisos amplios para gestionar recursos Azure
- La contraseña del administrador debe cumplir políticas de seguridad
- El connector necesita conectividad a internet para funcionar

## 📋 Requisitos del Sistema

- **Terraform** >= 1.0
- **Azure Provider** >= 2.46.0
- **NetApp Cloud Manager Provider**
- **Permisos Azure**: Owner o Contributor con capacidad de crear roles personalizados
- **Token NetApp**: Válido y con permisos apropiados
