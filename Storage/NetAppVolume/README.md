# Azure NetApp Files Volume Terraform Module

This Terraform module creates an Azure NetApp Files Volume within an existing NetApp Account and Capacity Pool.

## Features

- Creates Azure NetApp Files volumes with NFS, SMB (CIFS), or dual-protocol support
- Configurable service levels (Standard, Premium, Ultra)
- Export policy rules for NFS access control
- Cross-region replication support
- Snapshot policy integration
- Azure VMware Solution datastore support
- Flexible naming conventions with workload/environment/instance support

## Prerequisites

Before using this module, ensure the following resources exist:

1. **Resource Group** - The resource group where the NetApp resources are deployed
2. **NetApp Account** - An Azure NetApp Files account
3. **NetApp Capacity Pool** - A capacity pool within the NetApp account
4. **Delegated Subnet** - A subnet delegated to `Microsoft.NetApp/volumes`

## Usage

### Basic NFS Volume

```hcl
module "netapp_volume" {
  source = "path/to/Storage/NetAppVolume"

  resource_group_name = "rg-netapp-prod"
  location            = "eastus"
  account_name        = "netapp-account-prod"
  pool_name           = "pool-standard"

  name        = "vol-nfs-data"
  volume_path = "nfsdata"
  subnet_id   = "/subscriptions/.../subnets/netapp-subnet"

  storage_quota_in_gb = 100
  service_level       = "Standard"
  protocols           = ["NFSv3"]

  export_policy_rules = [
    {
      rule_index        = 1
      allowed_clients   = "10.0.0.0/24"
      protocols_enabled = ["NFSv3"]
      unix_read_only    = false
      unix_read_write   = true
      root_access_enabled = true
    }
  ]

  tags = {
    Environment = "Production"
    Application = "FileShare"
  }
}
```

### NFSv4.1 Volume with Kerberos

```hcl
module "netapp_volume_nfsv41" {
  source = "path/to/Storage/NetAppVolume"

  resource_group_name = "rg-netapp-prod"
  location            = "eastus"
  account_name        = "netapp-account-prod"
  pool_name           = "pool-premium"

  name        = "vol-nfs41-secure"
  volume_path = "nfs41secure"
  subnet_id   = "/subscriptions/.../subnets/netapp-subnet"

  storage_quota_in_gb = 500
  service_level       = "Premium"
  protocols           = ["NFSv4.1"]
  network_features    = "Standard"

  export_policy_rules = [
    {
      rule_index        = 1
      allowed_clients   = "10.0.0.0/16"
      protocols_enabled = ["NFSv4.1"]
      unix_read_only    = false
      unix_read_write   = true
      root_access_enabled = true
      kerberos_5p_read_write_enabled = true
    }
  ]

  tags = {
    Environment = "Production"
    Security    = "Kerberos"
  }
}
```

### SMB Volume (CIFS)

```hcl
module "netapp_volume_smb" {
  source = "path/to/Storage/NetAppVolume"

  resource_group_name = "rg-netapp-prod"
  location            = "eastus"
  account_name        = "netapp-account-prod"
  pool_name           = "pool-premium"

  name        = "vol-smb-share"
  volume_path = "smbshare"
  subnet_id   = "/subscriptions/.../subnets/netapp-subnet"

  storage_quota_in_gb = 1024
  service_level       = "Premium"
  protocols           = ["CIFS"]
  security_style      = "ntfs"

  tags = {
    Environment = "Production"
    Protocol    = "SMB"
  }
}
```

### Volume with Cross-Region Replication

```hcl
module "netapp_volume_replicated" {
  source = "path/to/Storage/NetAppVolume"

  resource_group_name = "rg-netapp-prod"
  location            = "eastus"
  account_name        = "netapp-account-prod"
  pool_name           = "pool-premium"

  name        = "vol-replicated"
  volume_path = "replicated"
  subnet_id   = "/subscriptions/.../subnets/netapp-subnet"

  storage_quota_in_gb = 500
  service_level       = "Premium"
  protocols           = ["NFSv3"]

  data_protection_replication = {
    endpoint_type             = "dst"
    remote_volume_location    = "westus"
    remote_volume_resource_id = "/subscriptions/.../volumes/source-volume"
    replication_frequency     = "10minutes"
  }

  tags = {
    Environment = "Production"
    Replication = "Enabled"
  }
}
```

### Volume with Snapshot Policy

```hcl
module "netapp_volume_snapshots" {
  source = "path/to/Storage/NetAppVolume"

  resource_group_name = "rg-netapp-prod"
  location            = "eastus"
  account_name        = "netapp-account-prod"
  pool_name           = "pool-standard"

  name        = "vol-with-snapshots"
  volume_path = "snapshotvol"
  subnet_id   = "/subscriptions/.../subnets/netapp-subnet"

  storage_quota_in_gb        = 200
  service_level              = "Standard"
  protocols                  = ["NFSv3"]
  snapshot_directory_visible = true

  data_protection_snapshot_policy = {
    snapshot_policy_id = "/subscriptions/.../snapshotPolicies/daily-policy"
  }

  tags = {
    Environment = "Production"
    Backup      = "Snapshots"
  }
}
```

### Ultra Performance Volume with Manual QoS

```hcl
module "netapp_volume_ultra" {
  source = "path/to/Storage/NetAppVolume"

  resource_group_name = "rg-netapp-prod"
  location            = "eastus"
  account_name        = "netapp-account-prod"
  pool_name           = "pool-ultra-manual"

  name        = "vol-ultra-db"
  volume_path = "ultradb"
  subnet_id   = "/subscriptions/.../subnets/netapp-subnet"

  storage_quota_in_gb = 2048
  service_level       = "Ultra"
  protocols           = ["NFSv4.1"]
  throughput_in_mibps = 256
  network_features    = "Standard"

  export_policy_rules = [
    {
      rule_index        = 1
      allowed_clients   = "10.1.0.0/24"
      protocols_enabled = ["NFSv4.1"]
      unix_read_write   = true
      root_access_enabled = true
    }
  ]

  tags = {
    Environment = "Production"
    Workload    = "Database"
    Performance = "Ultra"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | The name of the resource group where the NetApp Volume will be created. | `string` | n/a | yes |
| location | The Azure region where the NetApp Volume will be created. | `string` | n/a | yes |
| account_name | The name of the NetApp Account where the volume will be created. | `string` | n/a | yes |
| pool_name | The name of the NetApp Pool where the volume will be created. | `string` | n/a | yes |
| volume_path | A unique file path for the volume. Used when creating mount targets. | `string` | n/a | yes |
| subnet_id | The ID of the subnet where the volume will be created. Must be delegated to Microsoft.NetApp/volumes. | `string` | n/a | yes |
| storage_quota_in_gb | The maximum storage quota allowed for a file system in Gigabytes. Minimum is 100 GB. | `number` | n/a | yes |
| create | Controls whether resources should be created. | `bool` | `true` | no |
| name | The name of the NetApp Volume. If provided, overrides the generated name. | `string` | `null` | no |
| name_prefix | Prefix to use for the generated name if name is not provided. | `string` | `"anfvol"` | no |
| workload | The workload name to include in the generated name. | `string` | `null` | no |
| environment | The environment name (e.g., dev, staging, prod) to include in the generated name. | `string` | `null` | no |
| instance | The instance identifier to include in the generated name. | `string` | `null` | no |
| tags | A map of tags to apply to the NetApp Volume. | `map(string)` | `{}` | no |
| service_level | The target performance of the file system. Valid values are Standard, Premium, or Ultra. | `string` | `"Standard"` | no |
| protocols | The list of protocols enabled for the volume. Valid values are NFSv3, NFSv4.1, and CIFS. | `list(string)` | `["NFSv3"]` | no |
| security_style | Volume security style. Valid values are unix or ntfs. | `string` | `"unix"` | no |
| snapshot_directory_visible | Specifies whether the .snapshot directory is visible. | `bool` | `true` | no |
| throughput_in_mibps | Throughput of the volume in MiB/s. Required for manual QoS pools. | `number` | `null` | no |
| network_features | Network features for the volume. Valid values are Basic or Standard. | `string` | `"Basic"` | no |
| export_policy_rules | List of export policy rules for the volume. | `list(object)` | `null` | no |
| data_protection_replication | Data protection replication settings for cross-region replication. | `object` | `null` | no |
| data_protection_snapshot_policy | Data protection snapshot policy settings. | `object` | `null` | no |
| azure_vmware_data_store_enabled | Specifies whether the volume is enabled for Azure VMware Solution datastore purposes. | `bool` | `false` | no |

### Export Policy Rules Object

| Attribute | Description | Type | Default |
|-----------|-------------|------|---------|
| rule_index | The index number of the rule. | `number` | n/a |
| allowed_clients | List of allowed clients in CIDR notation. | `string` | n/a |
| protocols_enabled | List of protocols for the rule. | `list(string)` | n/a |
| unix_read_only | Is the file system read-only for UNIX? | `bool` | `false` |
| unix_read_write | Is the file system read-write for UNIX? | `bool` | `true` |
| root_access_enabled | Is root access permitted? | `bool` | `true` |
| kerberos_5_read_only_enabled | Is Kerberos 5 read-only enabled? | `bool` | `false` |
| kerberos_5_read_write_enabled | Is Kerberos 5 read-write enabled? | `bool` | `false` |
| kerberos_5i_read_only_enabled | Is Kerberos 5i read-only enabled? | `bool` | `false` |
| kerberos_5i_read_write_enabled | Is Kerberos 5i read-write enabled? | `bool` | `false` |
| kerberos_5p_read_only_enabled | Is Kerberos 5p read-only enabled? | `bool` | `false` |
| kerberos_5p_read_write_enabled | Is Kerberos 5p read-write enabled? | `bool` | `false` |

### Data Protection Replication Object

| Attribute | Description | Type |
|-----------|-------------|------|
| endpoint_type | The endpoint type. Valid values are src or dst. | `string` |
| remote_volume_location | The location of the remote volume. | `string` |
| remote_volume_resource_id | The resource ID of the remote volume. | `string` |
| replication_frequency | The replication frequency. Valid values are 10minutes, hourly, or daily. | `string` |

### Data Protection Snapshot Policy Object

| Attribute | Description | Type |
|-----------|-------------|------|
| snapshot_policy_id | The resource ID of the snapshot policy. | `string` |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the NetApp Volume. |
| name | The name of the NetApp Volume. |
| volume_path | The unique file path of the volume. |
| mount_ip_addresses | The list of IPv4 addresses for mounting the volume. |

## Mounting the Volume

### NFS Mount (Linux)

```bash
# NFSv3
sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp <mount_ip>:/<volume_path> /mnt/netapp

# NFSv4.1
sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=4.1,tcp <mount_ip>:/<volume_path> /mnt/netapp
```

### SMB Mount (Windows)

```powershell
net use Z: \\<mount_ip>\<volume_path>
```

## Service Levels and Performance

| Service Level | Throughput per TiB |
|---------------|-------------------|
| Standard | 16 MiB/s |
| Premium | 64 MiB/s |
| Ultra | 128 MiB/s |

## Important Notes

1. **Subnet Delegation**: The subnet must be delegated to `Microsoft.NetApp/volumes` before creating volumes.

2. **Volume Path**: Must be unique within the NetApp account and can only contain letters, numbers, and hyphens.

3. **Protocols**:
   - NFSv3 and NFSv4.1 can be used together (dual-protocol NFS)
   - CIFS requires Active Directory connection on the NetApp account
   - Dual-protocol (NFS + CIFS) requires specific configuration

4. **Replication**:
   - Cross-region replication requires volumes in different regions
   - Source volume uses `endpoint_type = "src"`, destination uses `endpoint_type = "dst"`

5. **QoS Types**:
   - Auto QoS: Throughput is automatically assigned based on quota and service level
   - Manual QoS: Set `throughput_in_mibps` explicitly (pool must be configured for manual QoS)

## License

This module is released under the MIT License.
