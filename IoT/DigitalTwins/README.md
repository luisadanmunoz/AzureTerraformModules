# Azure Digital Twins

Terraform module for creating and managing Azure Digital Twins instances.

## Features

- Create Azure Digital Twins instances for IoT modeling
- Managed identity support (System and User assigned)
- Integration with Azure IoT Hub and other services
- Model twin graphs of physical environments

## Usage

```hcl
module "digital_twins" {
  source = "path/to/IoT/DigitalTwins"

  name                = "my-digital-twins"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  tags = {
    Environment = "Production"
  }
}
```

### With System-Assigned Managed Identity

```hcl
module "digital_twins" {
  source = "path/to/IoT/DigitalTwins"

  name                = "my-digital-twins"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  identity_type = "SystemAssigned"

  tags = {
    Environment = "Production"
  }
}
```

### With User-Assigned Managed Identity

```hcl
module "digital_twins" {
  source = "path/to/IoT/DigitalTwins"

  name                = "my-digital-twins"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  identity_type = "UserAssigned"
  identity_ids  = [azurerm_user_assigned_identity.main.id]

  tags = {
    Environment = "Production"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the Digital Twins instance | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| location | The Azure region | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| identity_type | Managed identity type | `string` | `null` | no |
| identity_ids | User-assigned identity IDs | `list(string)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Digital Twins instance |
| name | The name of the Digital Twins instance |
| host_name | The hostname of the Digital Twins instance |
| principal_id | The principal ID of the managed identity |
| tenant_id | The tenant ID of the managed identity |

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
| [azurerm_digital_twins_instance.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Digital Twins resource. | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of user-assigned managed identity IDs. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. Possible values are SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Digital Twins instance should be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Digital Twins instance. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Digital Twins instance. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the Digital Twins instance. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_host_name"></a> [host\_name](#output\_host\_name) | The hostname of the Digital Twins instance. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Digital Twins instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Digital Twins instance. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned managed identity. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID of the system-assigned managed identity. |
<!-- END_TF_DOCS -->