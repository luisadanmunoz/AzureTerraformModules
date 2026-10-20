# Azure Elastic SAN Terraform Module

This Terraform module creates and manages Azure Elastic SAN resources, including the Elastic SAN itself, volume groups, and volumes.

## Description

Azure Elastic SAN is a cloud-native storage area network (SAN) offering that provides a scalable, cost-effective, high-performance, and comprehensive storage solution for a broad range of enterprise workloads. This module simplifies the deployment and management of Elastic SAN resources.

## Features

- Create Azure Elastic SAN with configurable SKU and size
- Support for Premium LRS and Premium ZRS SKUs
- Zone redundancy configuration
- Volume groups with encryption options (platform-managed or customer-managed keys)
- Network rules for volume groups
- Volume creation with optional source configuration
- Flexible naming convention support
- Comprehensive tagging

## Usage

### Basic Example - Premium LRS

```hcl
module "elastic_san" {
  source = "path/to/Storage/ElasticSAN"

  resource_group_name = "rg-storage-eastus"
  location            = "eastus"

  name_prefix = "esan"
  workload    = "app"
  environment = "dev"

  sku = {
    name = "Premium_LRS"
  }

  base_size_in_tib = 1

  volume_groups = {
    vg1 = {
      name            = "volume-group-01"
      encryption_type = "EncryptionAtRestWithPlatformKey"
      protocol_type   = "Iscsi"
    }
  }

  volumes = {
    vol1 = {
      volume_group_key = "vg1"
      name             = "volume-01"
      size_in_gib      = 100
    }
  }

  tags = {
    project = "my-project"
  }
}
```

### Premium ZRS with Zone Redundancy

```hcl
module "elastic_san_zrs" {
  source = "path/to/Storage/ElasticSAN"

  resource_group_name = "rg-storage-eastus"
  location            = "eastus"

  name        = "esan-production"
  environment = "prod"

  sku = {
    name = "Premium_ZRS"
  }

  base_size_in_tib     = 5
  extended_size_in_tib = 10
  zones                = ["1", "2", "3"]

  volume_groups = {
    databases = {
      name            = "vg-databases"
      encryption_type = "EncryptionAtRestWithPlatformKey"
      protocol_type   = "Iscsi"
      network_rules = {
        virtual_network_rules = [
          {
            subnet_id = "/subscriptions/xxx/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-main/subnets/snet-storage"
            action    = "Allow"
          }
        ]
      }
    }
    applications = {
      name            = "vg-applications"
      encryption_type = "EncryptionAtRestWithPlatformKey"
      protocol_type   = "Iscsi"
    }
  }

  volumes = {
    db_data = {
      volume_group_key = "databases"
      name             = "vol-db-data"
      size_in_gib      = 500
    }
    db_logs = {
      volume_group_key = "databases"
      name             = "vol-db-logs"
      size_in_gib      = 200
    }
    app_data = {
      volume_group_key = "applications"
      name             = "vol-app-data"
      size_in_gib      = 100
    }
  }

  tags = {
    environment = "production"
    criticality = "high"
  }
}
```

### Customer-Managed Key Encryption

```hcl
module "elastic_san_cmk" {
  source = "path/to/Storage/ElasticSAN"

  resource_group_name = "rg-storage-eastus"
  location            = "eastus"

  name_prefix = "esan"
  workload    = "secure"
  environment = "prod"

  sku = {
    name = "Premium_LRS"
  }

  base_size_in_tib = 2

  volume_groups = {
    encrypted = {
      name            = "vg-encrypted"
      encryption_type = "EncryptionAtRestWithCustomerManagedKey"
      protocol_type   = "Iscsi"
      encryption = {
        key_vault_key_id          = "https://myvault.vault.azure.net/keys/mykey/version"
        user_assigned_identity_id = "/subscriptions/xxx/resourceGroups/rg-identity/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-elasticsan"
      }
    }
  }

  volumes = {
    secure_data = {
      volume_group_key = "encrypted"
      name             = "vol-secure-data"
      size_in_gib      = 250
    }
  }

  tags = {
    security = "high"
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether resources should be created. | `bool` | `true` | no |
| resource_group_name | The name of the resource group in which to create the Elastic SAN. | `string` | n/a | yes |
| location | The Azure region where the Elastic SAN will be created. | `string` | n/a | yes |
| name | The name of the Elastic SAN. If provided, overrides the generated name. | `string` | `null` | no |
| name_prefix | The prefix to use for the generated Elastic SAN name. | `string` | `"esan"` | no |
| workload | The workload name to include in the generated name. | `string` | `null` | no |
| environment | The environment name to include in the generated name. | `string` | `null` | no |
| instance | The instance identifier to include in the generated name. | `string` | `null` | no |
| tags | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| sku | The SKU configuration for the Elastic SAN (name: Premium_LRS or Premium_ZRS, tier: optional). | `object` | n/a | yes |
| base_size_in_tib | The base size of the Elastic SAN in TiB (1-100). | `number` | n/a | yes |
| extended_size_in_tib | The extended size of the Elastic SAN in TiB. | `number` | `0` | no |
| zones | The availability zones for the Elastic SAN (1, 2, or 3). | `list(string)` | `null` | no |
| volume_groups | A map of volume groups to create within the Elastic SAN. | `map(object)` | `{}` | no |
| volumes | A map of volumes to create within volume groups. | `map(object)` | `{}` | no |

### Volume Groups Object Structure

```hcl
volume_groups = {
  key = {
    name            = string                                    # Required
    encryption_type = string                                    # Optional, default: "EncryptionAtRestWithPlatformKey"
    encryption = {                                              # Optional
      key_vault_key_id          = string                        # Required if encryption specified
      user_assigned_identity_id = string                        # Optional
    }
    network_rules = {                                           # Optional
      virtual_network_rules = [
        {
          subnet_id = string                                    # Required
          action    = string                                    # Optional, default: "Allow"
        }
      ]
    }
    protocol_type = string                                      # Optional, default: "Iscsi"
  }
}
```

### Volumes Object Structure

```hcl
volumes = {
  key = {
    volume_group_key = string                                   # Required
    name             = string                                   # Required
    size_in_gib      = number                                   # Required
    create_source = {                                           # Optional
      source_id   = string                                      # Required if create_source specified
      source_type = string                                      # Required: Disk, DiskRestorePoint, DiskSnapshot, VolumeSnapshot
    }
  }
}
```

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Elastic SAN. |
| name | The name of the Elastic SAN. |
| total_iops | The total IOPS of the Elastic SAN. |
| total_mbps | The total throughput in MBps of the Elastic SAN. |
| total_size_in_tib | The total size in TiB of the Elastic SAN. |
| total_volume_size_in_gib | The total volume size in GiB of the Elastic SAN. |
| volume_group_ids | A map of volume group names to their IDs. |
| volume_groups | A map of volume group details. |
| volume_ids | A map of volume names to their IDs. |
| volumes | A map of volume details including target IQN. |

## Dependencies

This module has the following dependencies:

- **Resource Group**: Must exist before creating the Elastic SAN
- **Key Vault Key**: Required when using customer-managed key encryption
- **User Assigned Identity**: Required when using customer-managed key encryption
- **Subnet**: Required when configuring network rules for volume groups

## Notes

- Elastic SAN is available in specific Azure regions. Check Azure documentation for availability.
- Premium_ZRS provides zone-redundant storage for higher availability.
- The base_size_in_tib determines the baseline IOPS and throughput.
- Extended size provides additional capacity without increasing base performance.
- Volumes must reference existing volume groups using the `volume_group_key`.

## License

This module is maintained by the Cloud Infrastructure team.
