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
