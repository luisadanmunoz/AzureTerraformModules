# Azure Storage Account Module

Modulo de Terraform para crear Storage Accounts en Azure con soporte para containers, file shares, network rules, versionado y diagnosticos.

## Uso Basico

```hcl
module "storage" {
  source = "../../modules/storage-account"

  name                = "stmiproyectodev001"
  resource_group_name = "rg-mi-proyecto-dev"
  location            = "westeurope"
}
```

## Uso con Containers y File Shares

```hcl
module "storage" {
  source = "../../modules/storage-account"

  name                     = "stempresaprod001"
  resource_group_name      = "rg-storage-prod"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "GRS"  # Geo-redundante

  # Blob Containers
  containers = [
    {
      name        = "documentos"
      access_type = "private"
    },
    {
      name        = "imagenes"
      access_type = "blob"  # Acceso anonimo a blobs
    },
    {
      name        = "backups"
      access_type = "private"
    }
  ]

  # File Shares para SMB
  file_shares = [
    {
      name        = "compartido"
      quota       = 100  # GB
      access_tier = "TransactionOptimized"
    },
    {
      name        = "archivos-frios"
      quota       = 500
      access_tier = "Cool"
    }
  ]

  tags = {
    Environment = "production"
    Department  = "IT"
  }
}
```

## Uso con Network Rules (Firewall)

```hcl
module "storage_seguro" {
  source = "../../modules/storage-account"

  name                          = "stsegurodatos001"
  resource_group_name           = "rg-storage-prod"
  location                      = "westeurope"
  public_network_access_enabled = true  # Necesario para aplicar reglas

  # Habilitar firewall
  enable_network_rules   = true
  network_default_action = "Deny"  # Denegar por defecto
  network_bypass         = ["AzureServices", "Logging", "Metrics"]

  # IPs permitidas
  network_ip_rules = [
    "203.0.113.0/24",     # Oficina principal
    "198.51.100.50"       # IP especifica
  ]

  # Subnets permitidas (requiere Service Endpoint)
  network_subnet_ids = [
    module.subnet_app.id,
    module.subnet_web.id
  ]

  tags = {
    SecurityLevel = "high"
  }
}
```

## Uso con Blob Versioning y Soft Delete

```hcl
module "storage_protegido" {
  source = "../../modules/storage-account"

  name                     = "stprotegido001"
  resource_group_name      = "rg-storage-prod"
  location                 = "westeurope"
  account_replication_type = "RAGRS"  # Read-access geo-redundant

  # Proteccion de datos
  enable_blob_properties        = true
  blob_versioning_enabled       = true   # Mantener versiones anteriores
  blob_change_feed_enabled      = true   # Registro de cambios
  blob_last_access_time_enabled = true   # Para lifecycle policies
  blob_delete_retention_days    = 30     # Soft delete blobs
  container_delete_retention_days = 30   # Soft delete containers

  containers = [
    {
      name        = "datos-criticos"
      access_type = "private"
    }
  ]
}
```

## Uso con Managed Identity

```hcl
module "storage_identity" {
  source = "../../modules/storage-account"

  name                = "stconidentidad001"
  resource_group_name = "rg-storage-prod"
  location            = "westeurope"

  # System Assigned Identity
  identity_type = "SystemAssigned"

  # O User Assigned Identity
  # identity_type = "UserAssigned"
  # identity_ids  = [azurerm_user_assigned_identity.storage.id]
}

# Asignar rol a la identidad
resource "azurerm_role_assignment" "storage_blob" {
  scope                = module.key_vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.storage_identity.identity[0].principal_id
}
```

## Uso con Diagnosticos

```hcl
module "storage_monitoreado" {
  source = "../../modules/storage-account"

  name                       = "stmonitoreado001"
  resource_group_name        = "rg-storage-prod"
  location                   = "westeurope"
  log_analytics_workspace_id = module.log_analytics.id  # Habilita diagnosticos

  containers = [
    {
      name        = "logs"
      access_type = "private"
    }
  ]
}
```

## Inputs

| Nombre | Descripcion | Tipo | Default | Requerido |
|--------|-------------|------|---------|-----------|
| `name` | Nombre (3-24 caracteres, minusculas y numeros) | `string` | - | Si |
| `resource_group_name` | Nombre del Resource Group | `string` | - | Si |
| `location` | Region de Azure | `string` | - | Si |
| `account_tier` | Tier: Standard o Premium | `string` | `"Standard"` | No |
| `account_replication_type` | Tipo de replicacion | `string` | `"LRS"` | No |
| `account_kind` | Tipo de cuenta | `string` | `"StorageV2"` | No |
| `access_tier` | Tier de acceso: Hot o Cool | `string` | `"Hot"` | No |
| `min_tls_version` | Version minima TLS | `string` | `"TLS1_2"` | No |
| `https_traffic_only_enabled` | Solo trafico HTTPS | `bool` | `true` | No |
| `shared_access_key_enabled` | Permitir Shared Keys | `bool` | `true` | No |
| `public_network_access_enabled` | Acceso desde red publica | `bool` | `true` | No |

### Blob Properties

| Nombre | Descripcion | Tipo | Default |
|--------|-------------|------|---------|
| `enable_blob_properties` | Habilitar configuracion blob | `bool` | `true` |
| `blob_versioning_enabled` | Versionado de blobs | `bool` | `false` |
| `blob_change_feed_enabled` | Change feed | `bool` | `false` |
| `blob_last_access_time_enabled` | Tracking ultimo acceso | `bool` | `false` |
| `blob_delete_retention_days` | Dias soft delete blobs | `number` | `7` |
| `container_delete_retention_days` | Dias soft delete containers | `number` | `7` |

### Network Rules

| Nombre | Descripcion | Tipo | Default |
|--------|-------------|------|---------|
| `enable_network_rules` | Habilitar firewall | `bool` | `false` |
| `network_default_action` | Accion por defecto | `string` | `"Deny"` |
| `network_bypass` | Servicios que bypasean | `list(string)` | `["AzureServices", "Logging", "Metrics"]` |
| `network_ip_rules` | IPs/CIDRs permitidos | `list(string)` | `[]` |
| `network_subnet_ids` | Subnets permitidas | `list(string)` | `[]` |

### Containers y File Shares

| Nombre | Descripcion | Tipo | Default |
|--------|-------------|------|---------|
| `containers` | Lista de containers | `list(object)` | `[]` |
| `file_shares` | Lista de file shares | `list(object)` | `[]` |

## Outputs

| Nombre | Descripcion |
|--------|-------------|
| `id` | ID del Storage Account |
| `name` | Nombre del Storage Account |
| `primary_blob_endpoint` | Endpoint de blob |
| `primary_file_endpoint` | Endpoint de files |
| `primary_access_key` | Clave de acceso primaria (sensitive) |
| `secondary_access_key` | Clave de acceso secundaria (sensitive) |
| `primary_connection_string` | Connection string (sensitive) |
| `identity` | Identidad del Storage Account |
| `container_ids` | IDs de containers creados |
| `file_share_ids` | IDs de file shares creados |

## Tipos de Replicacion

| Tipo | Descripcion | Disponibilidad | Durabilidad |
|------|-------------|----------------|-------------|
| `LRS` | Locally Redundant | 1 datacenter | 11 9s |
| `ZRS` | Zone Redundant | 3 zonas | 12 9s |
| `GRS` | Geo Redundant | 2 regiones | 16 9s |
| `GZRS` | Geo-Zone Redundant | 3 zonas + 1 region | 16 9s |
| `RAGRS` | Read-Access GRS | 2 regiones (lectura) | 16 9s |
| `RAGZRS` | Read-Access GZRS | 3 zonas + 1 region (lectura) | 16 9s |

## Tipos de Cuenta

| Tipo | Descripcion | Casos de Uso |
|------|-------------|--------------|
| `StorageV2` | Proposito general v2 | Recomendado para la mayoria |
| `BlobStorage` | Solo blobs | Blobs legacy |
| `BlockBlobStorage` | Premium blobs | Alto rendimiento |
| `FileStorage` | Premium files | SMB de alto rendimiento |
| `Storage` | Proposito general v1 | Legacy |

## Access Tiers

| Tier | Costo Almacenamiento | Costo Acceso | Caso de Uso |
|------|---------------------|--------------|-------------|
| Hot | Alto | Bajo | Datos accedidos frecuentemente |
| Cool | Medio | Medio | Datos accedidos ocasionalmente (30+ dias) |
| Archive | Bajo | Alto | Datos raramente accedidos (180+ dias) |

## Ejemplo con Private Endpoint

```hcl
# Storage Account
module "storage" {
  source = "../../modules/storage-account"

  name                          = "stprivado001"
  resource_group_name           = "rg-storage-prod"
  location                      = "westeurope"
  public_network_access_enabled = false  # Deshabilitar acceso publico

  containers = [
    {
      name        = "datos"
      access_type = "private"
    }
  ]
}

# Private Endpoint para Blob
resource "azurerm_private_endpoint" "blob" {
  name                = "pep-storage-blob"
  location            = "westeurope"
  resource_group_name = "rg-storage-prod"
  subnet_id           = module.subnet_pep.id

  private_service_connection {
    name                           = "psc-storage-blob"
    private_connection_resource_id = module.storage.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
```

## Recursos Creados

- `azurerm_storage_account.this` - El Storage Account
- `azurerm_storage_container.this` - Containers (por cada container)
- `azurerm_storage_share.this` - File Shares (por cada share)
- `azurerm_monitor_diagnostic_setting.blob` - Diagnosticos (opcional)

## Buenas Practicas de Seguridad

1. **Siempre usar HTTPS**: `https_traffic_only_enabled = true`
2. **TLS 1.2 minimo**: `min_tls_version = "TLS1_2"`
3. **Restringir acceso de red**: Usar network rules o private endpoints
4. **Habilitar soft delete**: Para recuperacion ante borrados accidentales
5. **Usar RBAC**: Preferir roles sobre shared keys
6. **Monitorear**: Habilitar diagnosticos para auditar accesos

<!-- BEGIN_TF_DOCS -->
# Azure Storage Account Module

Modulo reutilizable para crear Storage Accounts en Azure.
Incluye configuracion de seguridad, networking, blob containers y file shares.

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
| [azurerm_monitor_diagnostic_setting.blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Tier de acceso por defecto (Hot o Cool) | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Tipo de Storage Account | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Tipo de replicacion (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS) | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Tier de rendimiento (Standard o Premium) | `string` | `"Standard"` | no |
| <a name="input_blob_change_feed_enabled"></a> [blob\_change\_feed\_enabled](#input\_blob\_change\_feed\_enabled) | Habilitar change feed | `bool` | `false` | no |
| <a name="input_blob_delete_retention_days"></a> [blob\_delete\_retention\_days](#input\_blob\_delete\_retention\_days) | Dias de retencion para blobs eliminados (0 para deshabilitar) | `number` | `7` | no |
| <a name="input_blob_last_access_time_enabled"></a> [blob\_last\_access\_time\_enabled](#input\_blob\_last\_access\_time\_enabled) | Habilitar tracking de ultimo acceso | `bool` | `false` | no |
| <a name="input_blob_versioning_enabled"></a> [blob\_versioning\_enabled](#input\_blob\_versioning\_enabled) | Habilitar versionado de blobs | `bool` | `false` | no |
| <a name="input_container_delete_retention_days"></a> [container\_delete\_retention\_days](#input\_container\_delete\_retention\_days) | Dias de retencion para containers eliminados | `number` | `7` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | Lista de blob containers a crear | <pre>list(object({<br/>    name        = string<br/>    access_type = optional(string, "private")<br/>  }))</pre> | `[]` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags por defecto | `map(string)` | <pre>{<br/>  "ManagedBy": "Terraform"<br/>}</pre> | no |
| <a name="input_enable_blob_properties"></a> [enable\_blob\_properties](#input\_enable\_blob\_properties) | Habilitar configuracion de blob properties | `bool` | `true` | no |
| <a name="input_enable_network_rules"></a> [enable\_network\_rules](#input\_enable\_network\_rules) | Habilitar reglas de red | `bool` | `false` | no |
| <a name="input_file_shares"></a> [file\_shares](#input\_file\_shares) | Lista de file shares a crear | <pre>list(object({<br/>    name        = string<br/>    quota       = number<br/>    access_tier = optional(string, "TransactionOptimized")<br/>  }))</pre> | `[]` | no |
| <a name="input_https_traffic_only_enabled"></a> [https\_traffic\_only\_enabled](#input\_https\_traffic\_only\_enabled) | Permitir solo trafico HTTPS | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Lista de IDs de identidades asignadas por usuario | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Tipo de identidad (SystemAssigned, UserAssigned, SystemAssigned,UserAssigned) | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Region de Azure | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | ID del Log Analytics Workspace para diagnosticos | `string` | `null` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | Version minima de TLS | `string` | `"TLS1_2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Nombre del Storage Account (debe ser globalmente unico) | `string` | n/a | yes |
| <a name="input_network_bypass"></a> [network\_bypass](#input\_network\_bypass) | Servicios que pueden bypasear las reglas de red | `list(string)` | <pre>[<br/>  "AzureServices",<br/>  "Logging",<br/>  "Metrics"<br/>]</pre> | no |
| <a name="input_network_default_action"></a> [network\_default\_action](#input\_network\_default\_action) | Accion por defecto para trafico de red | `string` | `"Deny"` | no |
| <a name="input_network_ip_rules"></a> [network\_ip\_rules](#input\_network\_ip\_rules) | Lista de IPs o rangos CIDR permitidos | `list(string)` | `[]` | no |
| <a name="input_network_subnet_ids"></a> [network\_subnet\_ids](#input\_network\_subnet\_ids) | Lista de IDs de subnets permitidas | `list(string)` | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Permitir acceso desde redes publicas | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nombre del Resource Group | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Permitir acceso mediante Shared Access Keys | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags adicionales | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_container_ids"></a> [container\_ids](#output\_container\_ids) | IDs de los containers creados |
| <a name="output_file_share_ids"></a> [file\_share\_ids](#output\_file\_share\_ids) | IDs de los file shares creados |
| <a name="output_id"></a> [id](#output\_id) | ID del Storage Account |
| <a name="output_identity"></a> [identity](#output\_identity) | Identidad del Storage Account |
| <a name="output_name"></a> [name](#output\_name) | Nombre del Storage Account |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | Clave de acceso primaria |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | Endpoint primario de blob |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | Cadena de conexion primaria |
| <a name="output_primary_file_endpoint"></a> [primary\_file\_endpoint](#output\_primary\_file\_endpoint) | Endpoint primario de files |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | Clave de acceso secundaria |
<!-- END_TF_DOCS -->