# VirtualMachineScaleSet

Terraform module for creating Azure Virtual Machine Scale Sets (Linux and Windows).

## Features

- Linux and Windows VMSS support
- Autoscaling with CPU-based rules
- Multi-zone deployment with zone balancing
- Load Balancer and Application Gateway integration
- Data disk support
- Trusted Launch (Secure Boot, vTPM)
- Rolling upgrade support
- Managed Identity
- VM Extensions
- Boot diagnostics

## Usage

### Basic VMSS with Autoscaling

```hcl
module "vmss" {
  source = "./Compute/VirtualMachineScaleSet"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"
  name                = "vmss-web-prod-001"

  os_type   = "Linux"
  sku       = "Standard_D2s_v5"
  instances = 2
  subnet_id = module.subnet.id
  zones     = ["1", "2", "3"]

  admin_username = "adminuser"
  admin_ssh_keys = [{
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }]

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
  }

  autoscale = {
    enabled       = true
    min_count     = 2
    max_count     = 10
    default_count = 2
  }

  identity = { type = "SystemAssigned" }
}
```

### Windows VMSS with Load Balancer

```hcl
module "vmss_windows" {
  source = "./Compute/VirtualMachineScaleSet"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  os_type   = "Windows"
  sku       = "Standard_D4s_v5"
  instances = 3
  subnet_id = module.subnet.id

  admin_username = "adminuser"

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
  }

  load_balancer_backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.web.id
  ]

  health_probe_id = azurerm_lb_probe.http.id
  upgrade_mode    = "Rolling"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |
| random | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | VMSS name | `string` | `null` | no |
| os_type | OS type (Linux/Windows) | `string` | n/a | yes |
| sku | VM SKU size | `string` | n/a | yes |
| instances | Instance count | `number` | `2` | no |
| subnet_id | Subnet ID | `string` | n/a | yes |
| zones | Availability Zones | `list(string)` | `[]` | no |
| autoscale | Autoscale config | `object` | `{}` | no |
| identity | Managed Identity | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The VMSS ID |
| name | The VMSS name |
| unique_id | The VMSS unique ID |
| principal_id | System Assigned Identity Principal ID |
| admin_password | Auto-generated admin password |
| autoscale_setting_id | Autoscale Setting ID |
