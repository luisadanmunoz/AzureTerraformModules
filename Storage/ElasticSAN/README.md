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
| [azurerm_elastic_san.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/elastic_san) | resource |
| [azurerm_elastic_san_volume.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/elastic_san_volume) | resource |
| [azurerm_elastic_san_volume_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/elastic_san_volume_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_base_size_in_tib"></a> [base\_size\_in\_tib](#input\_base\_size\_in\_tib) | The base size of the Elastic SAN in TiB. Must be between 1 and 100. | `number` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name to include in the generated name (e.g., dev, staging, prod). | `string` | `null` | no |
| <a name="input_extended_size_in_tib"></a> [extended\_size\_in\_tib](#input\_extended\_size\_in\_tib) | The extended size of the Elastic SAN in TiB. Default is 0. | `number` | `0` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier to include in the generated name. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Elastic SAN will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Elastic SAN. If provided, overrides the generated name. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix to use for the generated Elastic SAN name. | `string` | `"esan"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Elastic SAN. DEPENDENCY: Must be an existing resource group. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU configuration for the Elastic SAN. | <pre>object({<br/>    name = string           # Premium_LRS or Premium_ZRS<br/>    tier = optional(string) # Optional tier specification<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_volume_groups"></a> [volume\_groups](#input\_volume\_groups) | A map of volume groups to create within the Elastic SAN.<br/><br/>Each volume group object supports:<br/>- name: The name of the volume group<br/>- encryption\_type: The encryption type (EncryptionAtRestWithPlatformKey or EncryptionAtRestWithCustomerManagedKey)<br/>- encryption: Optional encryption configuration for customer-managed keys<br/>  - key\_vault\_key\_id: The Key Vault Key URI. DEPENDENCY: Must be an existing Key Vault key.<br/>  - user\_assigned\_identity\_id: The User Assigned Identity ID. DEPENDENCY: Must be an existing User Assigned Identity.<br/>- network\_rules: Optional network rules configuration<br/>  - virtual\_network\_rules: List of virtual network rules<br/>    - subnet\_id: The subnet ID. DEPENDENCY: Must be an existing subnet.<br/>    - action: The action (Allow)<br/>- protocol\_type: The protocol type (Iscsi or None) | <pre>map(object({<br/>    name            = string<br/>    encryption_type = optional(string, "EncryptionAtRestWithPlatformKey")<br/>    encryption = optional(object({<br/>      key_vault_key_id          = string<br/>      user_assigned_identity_id = optional(string)<br/>    }))<br/>    network_rules = optional(object({<br/>      virtual_network_rules = optional(list(object({<br/>        subnet_id = string<br/>        action    = optional(string, "Allow")<br/>      })), [])<br/>    }))<br/>    protocol_type = optional(string, "Iscsi")<br/>  }))</pre> | `{}` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | A map of volumes to create within volume groups.<br/><br/>Each volume object supports:<br/>- volume\_group\_key: The key of the volume group to create this volume in<br/>- name: The name of the volume<br/>- size\_in\_gib: The size of the volume in GiB<br/>- create\_source: Optional source configuration for the volume<br/>  - source\_id: The source ID. DEPENDENCY: Must be an existing snapshot or volume.<br/>  - source\_type: The source type (Disk, DiskRestorePoint, DiskSnapshot, VolumeSnapshot) | <pre>map(object({<br/>    volume_group_key = string<br/>    name             = string<br/>    size_in_gib      = number<br/>    create_source = optional(object({<br/>      source_id   = string<br/>      source_type = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name to include in the generated name. | `string` | `null` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | The availability zones for the Elastic SAN. Valid values are '1', '2', or '3'. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Elastic SAN. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Elastic SAN. |
| <a name="output_total_iops"></a> [total\_iops](#output\_total\_iops) | The total IOPS of the Elastic SAN. |
| <a name="output_total_mbps"></a> [total\_mbps](#output\_total\_mbps) | The total throughput in MBps of the Elastic SAN. |
| <a name="output_total_size_in_tib"></a> [total\_size\_in\_tib](#output\_total\_size\_in\_tib) | The total size in TiB of the Elastic SAN. |
| <a name="output_total_volume_size_in_gib"></a> [total\_volume\_size\_in\_gib](#output\_total\_volume\_size\_in\_gib) | The total volume size in GiB of the Elastic SAN. |
| <a name="output_volume_group_ids"></a> [volume\_group\_ids](#output\_volume\_group\_ids) | A map of volume group names to their IDs. |
| <a name="output_volume_groups"></a> [volume\_groups](#output\_volume\_groups) | A map of volume group details. |
| <a name="output_volume_ids"></a> [volume\_ids](#output\_volume\_ids) | A map of volume names to their IDs. |
| <a name="output_volumes"></a> [volumes](#output\_volumes) | A map of volume details. |
<!-- END_TF_DOCS -->