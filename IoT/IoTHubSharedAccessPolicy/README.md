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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_iothub_shared_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_shared_access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the shared access policy resource. | `bool` | `true` | no |
| <a name="input_device_connect"></a> [device\_connect](#input\_device\_connect) | Whether to grant device connect permission. | `bool` | `false` | no |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | The name of the IoT Hub. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the shared access policy. | `string` | n/a | yes |
| <a name="input_registry_read"></a> [registry\_read](#input\_registry\_read) | Whether to grant registry read permission. | `bool` | `false` | no |
| <a name="input_registry_write"></a> [registry\_write](#input\_registry\_write) | Whether to grant registry write permission. Implies registry\_read. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_service_connect"></a> [service\_connect](#input\_service\_connect) | Whether to grant service connect permission. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (not applied to resource, kept for consistency). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IoT Hub Shared Access Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the IoT Hub Shared Access Policy. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string of the Shared Access Policy. |
| <a name="output_primary_key"></a> [primary\_key](#output\_primary\_key) | The primary key of the Shared Access Policy. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The secondary connection string of the Shared Access Policy. |
| <a name="output_secondary_key"></a> [secondary\_key](#output\_secondary\_key) | The secondary key of the Shared Access Policy. |
<!-- END_TF_DOCS -->