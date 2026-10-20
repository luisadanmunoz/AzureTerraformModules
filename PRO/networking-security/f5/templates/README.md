# Azure F5 Templates Module

Este directorio contiene plantillas para la configuración de dispositivos F5 en Azure.

## 🚀 Características

- **Plantillas de configuración** para F5 BIG-IP
- **Onboarding automático** de dispositivos
- **Configuración de 2 NICs** para alta disponibilidad
- **Templates personalizables** para diferentes entornos

## 📁 Archivos Incluidos

| Archivo | Descripción |
|---------|-------------|
| `f5_onboard.tmpl` | Plantilla principal de onboarding para F5 |
| `onboard_do_2nic.tpl` | Plantilla de configuración para 2 NICs |

## 📦 Requisitos

- F5 BIG-IP en Azure
- Acceso a la consola de administración F5
- Conocimientos de configuración F5

## 📘 Uso

Estas plantillas son utilizadas por el módulo principal de F5 para configurar automáticamente los dispositivos F5 en Azure.

### Ejemplo de Integración

```hcl
module "f5_device" {
  source = "./modules/f5"
  
  # El módulo utilizará estas plantillas automáticamente
  # para configurar el dispositivo F5
}
```

## ⚠️ Notas Importantes

- Estas son plantillas de configuración, no módulos Terraform independientes
- Requieren ser utilizadas junto con el módulo principal de F5
- Las plantillas pueden necesitar personalización según el entorno específico

## 📋 Requisitos del Sistema

- **F5 BIG-IP** desplegado en Azure
- **Módulo F5 principal** para utilizar estas plantillas
- **Permisos** de administración en el dispositivo F5
