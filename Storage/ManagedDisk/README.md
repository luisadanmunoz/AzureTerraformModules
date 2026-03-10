# Azure Managed Disk Terraform Module

This Terraform module creates and manages Azure Managed Disks with support for various storage types including Standard HDD, Standard SSD, Premium SSD, Premium SSD v2, and Ultra SSD.

## Features

- Support for all Azure Managed Disk storage types
- Flexible naming with explicit name or generated name from components
- Zone redundancy support
- Shared disk support for clustering scenarios
- On-demand bursting for Premium disks
- Server-side encryption with platform-managed or customer-managed keys
- Confidential VM disk encryption support
- Private endpoint access through Disk Access resources
- Encryption settings with Key Vault integration

## Usage

### Standard SSD Disk

```hcl
module "standard_ssd_disk" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-standard-ssd"
  storage_account_type = "StandardSSD_LRS"
  disk_size_gb         = 128

  tags = {
    Environment = "dev"
    Project     = "example"
  }
}
```

### Premium SSD Disk

```hcl
module "premium_ssd_disk" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-premium-ssd"
  storage_account_type = "Premium_LRS"
  disk_size_gb         = 256
  zone                 = "1"

  # Enable on-demand bursting for Premium disks
  on_demand_bursting_enabled = true

  tags = {
    Environment = "prod"
    Project     = "example"
  }
}
```

### Ultra SSD Disk

```hcl
module "ultra_ssd_disk" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-ultra-ssd"
  storage_account_type = "UltraSSD_LRS"
  disk_size_gb         = 512
  zone                 = "1"

  # Configure IOPS and throughput for Ultra SSD
  disk_iops_read_write = 10000
  disk_mbps_read_write = 500

  # Optional: Configure read-only IOPS for shared disks
  # disk_iops_read_only = 5000
  # disk_mbps_read_only = 250

  # Optional: Set logical sector size (512 or 4096)
  logical_sector_size = 512

  tags = {
    Environment = "prod"
    Project     = "high-performance"
  }
}
```

### Premium SSD v2 Disk

```hcl
module "premiumv2_disk" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-premiumv2"
  storage_account_type = "PremiumV2_LRS"
  disk_size_gb         = 256
  zone                 = "2"

  # Configure IOPS and throughput independently
  disk_iops_read_write = 5000
  disk_mbps_read_write = 200

  tags = {
    Environment = "prod"
    Project     = "example"
  }
}
```

### Shared Disk for Clustering

```hcl
module "shared_disk" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-shared-cluster"
  storage_account_type = "Premium_LRS"
  disk_size_gb         = 1024
  zone                 = "1"

  # Enable shared disk with max 3 concurrent attachments
  max_shares = 3

  tags = {
    Environment = "prod"
    Project     = "cluster"
  }
}
```

### Disk with Customer-Managed Key Encryption

```hcl
module "encrypted_disk" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-encrypted"
  storage_account_type = "Premium_LRS"
  disk_size_gb         = 256

  # Server-side encryption with customer-managed key
  disk_encryption_set_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example/providers/Microsoft.Compute/diskEncryptionSets/des-example"

  tags = {
    Environment = "prod"
    Project     = "secure"
  }
}
```

### Disk with Encryption Settings (Key Vault)

```hcl
module "disk_with_encryption_settings" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-keyvault-encrypted"
  storage_account_type = "Premium_LRS"
  disk_size_gb         = 256

  encryption_settings = {
    disk_encryption_key = {
      secret_url      = "https://example-keyvault.vault.azure.net/secrets/disk-encryption-key/abc123"
      source_vault_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example/providers/Microsoft.KeyVault/vaults/example-keyvault"
    }
    key_encryption_key = {
      key_url         = "https://example-keyvault.vault.azure.net/keys/key-encryption-key/def456"
      source_vault_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example/providers/Microsoft.KeyVault/vaults/example-keyvault"
    }
  }

  tags = {
    Environment = "prod"
    Project     = "secure"
  }
}
```

### Disk with Private Network Access

```hcl
module "private_disk" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-private"
  storage_account_type = "Premium_LRS"
  disk_size_gb         = 256

  # Configure private network access
  network_access_policy         = "AllowPrivate"
  disk_access_id                = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example/providers/Microsoft.Compute/diskAccesses/da-example"
  public_network_access_enabled = false

  tags = {
    Environment = "prod"
    Project     = "secure"
  }
}
```

### Copy Disk from Existing Disk

```hcl
module "copied_disk" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-copy"
  storage_account_type = "Premium_LRS"
  disk_size_gb         = 256
  create_option        = "Copy"
  source_resource_id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-source/providers/Microsoft.Compute/disks/disk-source"

  tags = {
    Environment = "prod"
    Project     = "migration"
  }
}
```

### Disk from Image

```hcl
module "disk_from_image" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  name                 = "disk-from-image"
  storage_account_type = "Premium_LRS"
  disk_size_gb         = 128
  create_option        = "FromImage"
  os_type              = "Linux"
  hyper_v_generation   = "V2"

  gallery_image_reference_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-gallery/providers/Microsoft.Compute/galleries/myGallery/images/myImage/versions/1.0.0"

  tags = {
    Environment = "prod"
    Project     = "deployment"
  }
}
```

### Generated Naming Example

```hcl
module "generated_name_disk" {
  source = "path/to/Storage/ManagedDisk"

  resource_group_name = "rg-example"
  location            = "eastus"

  # Will generate name: disk-webapp-prod-001
  name_prefix  = "disk"
  workload     = "webapp"
  environment  = "prod"
  instance     = "001"

  storage_account_type = "Premium_LRS"
  disk_size_gb         = 256

  tags = {
    Environment = "prod"
    Project     = "webapp"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_managed_disk.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the Managed Disk resource. | `bool` | `true` | no |
| resource_group_name | The name of the Resource Group where the Managed Disk will be created. | `string` | n/a | yes |
| location | The Azure region where the Managed Disk will be created. | `string` | n/a | yes |
| name | The explicit name for the Managed Disk. If provided, this takes precedence over generated names. | `string` | `null` | no |
| name_prefix | The prefix to use for the generated Managed Disk name. | `string` | `"disk"` | no |
| workload | The workload name to include in the generated name. | `string` | `null` | no |
| environment | The environment name to include in the generated name. | `string` | `null` | no |
| instance | The instance identifier to include in the generated name. | `string` | `null` | no |
| tags | A map of tags to apply to the Managed Disk resource. | `map(string)` | `{}` | no |
| storage_account_type | The type of storage to use for the Managed Disk. Valid values: Standard_LRS, StandardSSD_LRS, StandardSSD_ZRS, Premium_LRS, Premium_ZRS, PremiumV2_LRS, UltraSSD_LRS. | `string` | n/a | yes |
| create_option | The method to use when creating the Managed Disk. Valid values: Empty, Copy, FromImage, Import, ImportSecure, Restore, Upload. | `string` | `"Empty"` | no |
| disk_size_gb | The size of the Managed Disk in gigabytes. | `number` | n/a | yes |
| disk_iops_read_write | The number of IOPS allowed for this disk. Only settable for UltraSSD_LRS and PremiumV2_LRS disks. | `number` | `null` | no |
| disk_mbps_read_write | The bandwidth allowed for this disk in MB per second. Only settable for UltraSSD_LRS and PremiumV2_LRS disks. | `number` | `null` | no |
| disk_iops_read_only | The number of IOPS allowed across all VMs mounting the shared disk as read-only. | `number` | `null` | no |
| disk_mbps_read_only | The bandwidth allowed across all VMs mounting the shared disk as read-only in MB per second. | `number` | `null` | no |
| source_resource_id | The ID of an existing Managed Disk or Snapshot to copy when create_option is Copy or Restore. | `string` | `null` | no |
| source_uri | The URI to a valid VHD file to be used when create_option is Import or ImportSecure. | `string` | `null` | no |
| storage_account_id | The ID of the Storage Account where the source_uri is located. Required when create_option is Import or ImportSecure. | `string` | `null` | no |
| image_reference_id | The ID of an existing Platform Image to use when create_option is FromImage. | `string` | `null` | no |
| gallery_image_reference_id | The ID of a Gallery Image Version to use when create_option is FromImage. | `string` | `null` | no |
| logical_sector_size | The logical sector size in bytes for Ultra disks. Possible values are 512 or 4096. | `number` | `null` | no |
| os_type | Specify a value when the source contains an operating system. Valid values: Linux, Windows. | `string` | `null` | no |
| tier | The disk performance tier to use. Only applicable to disks of type Premium_LRS. | `string` | `null` | no |
| max_shares | The maximum number of VMs that can attach to the disk at the same time. Value greater than 1 indicates a shared disk. | `number` | `null` | no |
| zone | The Availability Zone in which the Managed Disk should be located. Valid values: 1, 2, 3. | `string` | `null` | no |
| network_access_policy | The policy for accessing the disk via network. Valid values: AllowAll, AllowPrivate, DenyAll. | `string` | `"AllowAll"` | no |
| disk_access_id | The ID of the disk access resource for using private endpoints on disks. Required when network_access_policy is AllowPrivate. | `string` | `null` | no |
| public_network_access_enabled | Whether it is allowed to access the disk via public network. | `bool` | `true` | no |
| on_demand_bursting_enabled | Specifies if On-Demand Bursting is enabled for the Managed Disk. | `bool` | `false` | no |
| trusted_launch_enabled | Specifies if Trusted Launch is enabled for the Managed Disk. | `bool` | `false` | no |
| secure_vm_disk_encryption_set_id | The ID of the Disk Encryption Set for Confidential VM disk encryption. | `string` | `null` | no |
| security_type | The security type of the Managed Disk when used with Confidential VMs. | `string` | `null` | no |
| hyper_v_generation | The Hyper-V Generation of the Disk. Valid values: V1, V2. | `string` | `null` | no |
| encryption_settings | Encryption settings for the Managed Disk with disk_encryption_key and key_encryption_key. | `object` | `null` | no |
| disk_encryption_set_id | The ID of the Disk Encryption Set for server-side encryption with customer-managed keys. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Managed Disk. |
| name | The name of the Managed Disk. |
| disk_size_gb | The size of the Managed Disk in gigabytes. |
| storage_account_type | The storage account type of the Managed Disk. |

## Storage Account Types

| Type | Description | Use Case |
|------|-------------|----------|
| Standard_LRS | Standard HDD with local redundancy | Dev/test, backups, infrequent access |
| StandardSSD_LRS | Standard SSD with local redundancy | Web servers, light enterprise apps |
| StandardSSD_ZRS | Standard SSD with zone redundancy | HA workloads requiring zone redundancy |
| Premium_LRS | Premium SSD with local redundancy | Production workloads, databases |
| Premium_ZRS | Premium SSD with zone redundancy | Production HA requiring zone redundancy |
| PremiumV2_LRS | Premium SSD v2 with local redundancy | Performance-sensitive production workloads |
| UltraSSD_LRS | Ultra SSD with local redundancy | I/O-intensive workloads, SAP HANA, databases |

## License

This module is licensed under the MIT License.
