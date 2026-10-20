# Azure IoT Hub Shared Access Policy

Terraform module for creating and managing Azure IoT Hub Shared Access Policies.

## Features

- Create custom shared access policies with granular permissions
- Registry read/write access control
- Service connect permission for cloud-to-device messaging
- Device connect permission for device operations
- Automatic generation of connection strings and keys

## Usage

```hcl
module "iot_hub_sap" {
  source = "path/to/IoT/IoTHubSharedAccessPolicy"

  name                = "service-policy"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name

  registry_read   = true
  registry_write  = false
  service_connect = true
  device_connect  = false
}
```

### Device Policy

```hcl
module "iot_hub_sap_device" {
  source = "path/to/IoT/IoTHubSharedAccessPolicy"

  name                = "device-policy"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name

  registry_read   = false
  registry_write  = false
  service_connect = false
  device_connect  = true
}
```

### Registry Manager Policy

```hcl
module "iot_hub_sap_registry" {
  source = "path/to/IoT/IoTHubSharedAccessPolicy"

  name                = "registry-manager"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name

  registry_read   = true
  registry_write  = true
  service_connect = false
  device_connect  = false
}
```

### Full Access Policy

```hcl
module "iot_hub_sap_full" {
  source = "path/to/IoT/IoTHubSharedAccessPolicy"

  name                = "full-access"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name

  registry_read   = true
  registry_write  = true
  service_connect = true
  device_connect  = true
}
```

## Permissions

| Permission | Description |
|------------|-------------|
| registry_read | Read access to the identity registry |
| registry_write | Write access to the identity registry (implies registry_read) |
| service_connect | Access cloud-side endpoints (receive D2C, send C2D) |
| device_connect | Access device-side endpoints (send D2C, receive C2D) |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the policy | `string` | n/a | yes |
| iothub_name | The name of the IoT Hub | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| registry_read | Grant registry read permission | `bool` | `false` | no |
| registry_write | Grant registry write permission | `bool` | `false` | no |
| service_connect | Grant service connect permission | `bool` | `false` | no |
| device_connect | Grant device connect permission | `bool` | `false` | no |
| tags | Resource tags (not applied) | `map(string)` | `{}` | no |

## Outputs

| Name | Description | Sensitive |
|------|-------------|:---------:|
| id | The ID of the Policy | no |
| name | The name of the Policy | no |
| primary_key | The primary key | yes |
| secondary_key | The secondary key | yes |
| primary_connection_string | The primary connection string | yes |
| secondary_connection_string | The secondary connection string | yes |
