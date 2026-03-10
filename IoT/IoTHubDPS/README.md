# Azure IoT Hub Device Provisioning Service (DPS)

Terraform module for creating and managing Azure IoT Hub Device Provisioning Service resources.

## Features

- Automatic device provisioning for IoT Hub
- Multiple allocation policies (Hashed, GeoLatency, Static)
- Link multiple IoT Hubs for multi-hub scenarios
- IP filter rules for network security
- Data residency support
- Public network access control

## Usage

```hcl
module "iot_hub_dps" {
  source = "path/to/IoT/IoTHubDPS"

  name                = "my-iot-dps"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  allocation_policy = "Hashed"

  tags = {
    Environment = "Production"
  }
}
```

### With Linked IoT Hubs

```hcl
module "iot_hub_dps" {
  source = "path/to/IoT/IoTHubDPS"

  name                = "my-iot-dps"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  allocation_policy = "GeoLatency"

  linked_hubs = [
    {
      connection_string       = module.iot_hub_primary.shared_access_policy[0].primary_connection_string
      location                = "eastus"
      apply_allocation_policy = true
      allocation_weight       = 1
    },
    {
      connection_string       = module.iot_hub_secondary.shared_access_policy[0].primary_connection_string
      location                = "westus"
      apply_allocation_policy = true
      allocation_weight       = 1
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

### With IP Filter Rules

```hcl
module "iot_hub_dps" {
  source = "path/to/IoT/IoTHubDPS"

  name                = "my-iot-dps"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  public_network_access_enabled = true

  ip_filter_rules = [
    {
      name    = "allow-office"
      ip_mask = "10.0.0.0/24"
      action  = "Accept"
    },
    {
      name    = "deny-all"
      ip_mask = "0.0.0.0/0"
      action  = "Reject"
    }
  ]

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
| name | The name of the DPS | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| location | The Azure region | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| sku_name | The SKU name (S1) | `string` | `"S1"` | no |
| sku_capacity | The number of units | `number` | `1` | no |
| allocation_policy | Allocation policy (Hashed, GeoLatency, Static) | `string` | `"Hashed"` | no |
| data_residency_enabled | Enable data residency | `bool` | `false` | no |
| public_network_access_enabled | Enable public network access | `bool` | `true` | no |
| linked_hubs | List of linked IoT Hubs | `list(object)` | `[]` | no |
| ip_filter_rules | IP filter rules | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the DPS |
| name | The name of the DPS |
| service_operations_host_name | The service operations host name |
| device_provisioning_host_name | The device provisioning host name |
| id_scope | The unique identifier scope |
| allocation_policy | The allocation policy |
