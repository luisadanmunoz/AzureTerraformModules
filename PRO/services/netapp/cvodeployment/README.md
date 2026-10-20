# Terraform Azure NetApp CVO Deployment Module

Este módulo de Terraform despliega un Cloud Volumes ONTAP (CVO) de NetApp en Azure con configuración de alta disponibilidad y encriptación.

## 🚀 Características

- **Cloud Volumes ONTAP** en Azure
- **Configuración de alta disponibilidad** opcional
- **Encriptación de datos** con Azure Key Vault
- **Etiquetado** personalizable
- **Storage premium** configurado
- **Workspace** de NetApp Cloud Manager

## 📦 Requisitos

- Terraform >= 1.0
- Azure Provider >= 2.46.0
- NetApp Cloud Manager Provider
- Token de NetApp Cloud Manager
- Cloud Manager Connector desplegado

## 🔧 Variables de Entrada

Este módulo actualmente tiene valores hardcodeados. Las variables principales serían:

| Nombre | Descripción | Tipo | Por Defecto | Obligatorio |
|--------|-------------|------|-------------|-------------|
| `token` | Token de NetApp Cloud Manager | `string` | - | ✅ |
| `name` | Nombre del CVO | `string` | - | ✅ |
| `location` | Región de Azure | `string` | - | ✅ |
| `subscription_id` | ID de la suscripción | `string` | - | ✅ |
| `vnet_id` | ID de la VNet | `string` | - | ✅ |
| `subnet_id` | ID de la subnet | `string` | - | ✅ |
| `workspace_id` | ID del workspace | `string` | - | ✅ |
| `client_id` | ID del cliente/connector | `string` | - | ✅ |

## 📤 Outputs

| Nombre | Descripción |
|--------|-------------|
| `current_subscription_display_name` | Nombre de la suscripción actual |
| `current_subscription_display_id` | ID de la suscripción actual |

## 📘 Ejemplo de Uso

```hcl
module "netapp_cvo" {
  source = "./modules/cvodeployment"

  # Nota: Este módulo necesita ser actualizado para usar variables
  # Actualmente tiene valores hardcodeados
}
```

## 🏗️ Recursos Creados

- **netapp-cloudmanager_cvo_azure** - Cloud Volumes ONTAP en Azure

## ⚙️ Configuración Actual

### Configuración Básica
- **Nombre**: "ManagedServiceIdentity"
- **Ubicación**: "westeurope"
- **Zona de disponibilidad**: 2
- **Tipo de storage**: Premium_LRS
- **Encriptación**: AZURE
- **Alta disponibilidad**: false
- **Paquete de capacidad**: Freemium

### Etiquetas Azure
```hcl
azure_tag {
  tag_key   = "abcd"
  tag_value = "ABCD"
}
azure_tag {
  tag_key   = "xxx"
  tag_value = "YYY"
}
```

## 🔐 Configuración de Seguridad

### Encriptación
- **Tipo**: AZURE (encriptación nativa de Azure)
- **Contraseña SVM**: Configurada en el módulo

### Alta Disponibilidad
- **is_ha**: false (configuración actual)
- Para HA, cambiar a true y configurar zonas adicionales

## ⚠️ Notas Importantes

- Este módulo actualmente tiene valores hardcodeados
- Necesita ser refactorizado para usar variables
- Requiere Cloud Manager Connector previamente desplegado
- La contraseña SVM está hardcodeada (cambiar por variable)
- Incluye configuración comentada para HA con encriptación avanzada

## 🔄 Configuración Alternativa (Comentada)

El módulo incluye una configuración alternativa comentada que muestra:
- Configuración de alta disponibilidad
- Encriptación con Azure Key Vault
- Capacity tier con Blob storage
- Parámetros de encriptación avanzados

## 📋 Requisitos del Sistema

- **Terraform** >= 1.0
- **Azure Provider** >= 2.46.0
- **NetApp Cloud Manager Provider**
- **Cloud Manager Connector** desplegado
- **Permisos Azure**: Contributor en el Resource Group
- **Token NetApp**: Válido y con permisos apropiados
