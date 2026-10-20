# VirtualMachine

Terraform module for creating Azure Virtual Machines (Linux and Windows).

## Features

- Linux and Windows VM support
- Automatic NIC and Public IP creation
- Data disk attachment
- Trusted Launch (Secure Boot, vTPM)
- Spot VM support with eviction policies
- Managed Identity (System/User Assigned)
- VM Extensions
- Boot diagnostics
- Availability Set / Zone placement
- Proximity Placement Group support
- Dedicated Host support
- Hybrid Benefit licensing
- Auto-generated admin password

## Usage

### Linux VM with SSH

```hcl
module "linux_vm" {
  source = "./Compute/VirtualMachine"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"
  name                = "vm-linux-prod-001"
  os_type             = "Linux"
  size                = "Standard_D4s_v5"
  subnet_id           = module.subnet.id

  admin_username                  = "adminuser"
  disable_password_authentication = true
  admin_ssh_keys = [{
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }]

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity = {
    type = "SystemAssigned"
  }
}
```

### Windows VM

```hcl
module "windows_vm" {
  source = "./Compute/VirtualMachine"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"
  name                = "vm-win-prod-001"
  os_type             = "Windows"
  size                = "Standard_D4s_v5"
  subnet_id           = module.subnet.id
  zone                = "1"

  admin_username = "adminuser"
  # Password auto-generated

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }

  # Trusted Launch
  secure_boot_enabled = true
  vtpm_enabled        = true

  # Data disks
  data_disks = [
    {
      lun          = 0
      disk_size_gb = 128
    },
    {
      lun          = 1
      disk_size_gb = 256
    }
  ]
}

output "admin_password" {
  value     = module.windows_vm.admin_password
  sensitive = true
}
```

### Spot VM

```hcl
module "spot_vm" {
  source = "./Compute/VirtualMachine"

  resource_group_name = "rg-compute-dev-001"
  location            = "westeurope"
  os_type             = "Linux"
  size                = "Standard_D8s_v5"
  subnet_id           = module.subnet.id

  priority        = "Spot"
  eviction_policy = "Deallocate"
  max_bid_price   = 0.5

  admin_username = "adminuser"
  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
  }
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
| create | Controls whether to create the resource | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | VM name | `string` | `null` | no |
| os_type | OS type (Linux/Windows) | `string` | n/a | yes |
| size | VM SKU size | `string` | n/a | yes |
| admin_username | Admin username | `string` | n/a | yes |
| admin_password | Admin password | `string` | `null` | no |
| subnet_id | Subnet ID for NIC | `string` | `null` | no |
| source_image_reference | Marketplace image | `object` | `null` | no |
| zone | Availability Zone | `string` | `null` | no |
| identity | Managed Identity config | `object` | `null` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Virtual Machine |
| name | The name of the Virtual Machine |
| private_ip_address | The primary private IP address |
| public_ip_address | The public IP address |
| principal_id | The Principal ID of System Assigned Identity |
| admin_password | The auto-generated admin password |

## Common Image References

### Windows
```hcl
# Windows Server 2022
source_image_reference = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2022-datacenter-g2"
}

# Windows 11
source_image_reference = {
  publisher = "MicrosoftWindowsDesktop"
  offer     = "windows-11"
  sku       = "win11-23h2-pro"
}
```

### Linux
```hcl
# Ubuntu 22.04
source_image_reference = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
}

# RHEL 9
source_image_reference = {
  publisher = "RedHat"
  offer     = "RHEL"
  sku       = "9-lvm-gen2"
}
```
