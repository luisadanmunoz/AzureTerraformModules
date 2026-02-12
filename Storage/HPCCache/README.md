# Azure HPC Cache Terraform Module

This Terraform module creates and manages an Azure HPC Cache resource. Azure HPC Cache accelerates access to your data for high-performance computing (HPC) tasks by caching data from various sources including NFS storage, Azure Blob Storage, and on-premises NAS systems.

## Features

- Configurable cache size and SKU for different performance tiers
- Support for customer-managed key encryption
- Managed identity support (SystemAssigned, UserAssigned, or both)
- DNS configuration for name resolution
- Default access policy with customizable access rules
- Directory service integration (Active Directory, LDAP, Flat File)
- Flexible naming with prefix, workload, environment, and instance components

## Usage

### Basic Example

```hcl
module "hpc_cache" {
  source = "../../"

  resource_group_name = "rg-hpc-workload"
  location            = "eastus"
  name                = "hpccache-prod"
  cache_size_in_gb    = 3072
  sku_name            = "Standard_2G"
  subnet_id           = "/subscriptions/xxx/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-hpc/subnets/snet-hpccache"

  tags = {
    Environment = "Production"
    Project     = "HPC-Workload"
  }
}
```

### Example with NFS Storage Target

```hcl
module "hpc_cache" {
  source = "../../"

  resource_group_name = "rg-hpc-workload"
  location            = "eastus"
  name                = "hpccache-prod"
  cache_size_in_gb    = 12288
  sku_name            = "Standard_4G"
  subnet_id           = "/subscriptions/xxx/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-hpc/subnets/snet-hpccache"

  # DNS configuration for NFS target resolution
  dns = {
    servers       = ["10.0.1.4", "10.0.1.5"]
    search_domain = "hpc.local"
  }

  # Default access policy for NFS clients
  default_access_policy = [
    {
      scope                   = "default"
      access                  = "rw"
      root_squash_enabled     = false
      submount_access_enabled = true
      suid_enabled            = true
    },
    {
      scope                   = "network"
      access                  = "ro"
      filter                  = "10.0.2.0/24"
      root_squash_enabled     = true
      submount_access_enabled = false
      suid_enabled            = false
    }
  ]

  tags = {
    Environment = "Production"
    Project     = "HPC-Workload"
  }
}

# NFS Storage Target
resource "azurerm_hpc_cache_nfs_target" "nfs" {
  name                = "nfs-target"
  resource_group_name = "rg-hpc-workload"
  cache_name          = module.hpc_cache.name
  target_host_name    = "nfs-server.hpc.local"
  usage_model         = "READ_HEAVY_INFREQ"

  namespace_junction {
    namespace_path = "/data"
    nfs_export     = "/export/data"
    target_path    = ""
  }
}
```

### Example with Customer-Managed Key Encryption

```hcl
module "hpc_cache" {
  source = "../../"

  resource_group_name = "rg-hpc-workload"
  location            = "eastus"
  name                = "hpccache-secure"
  cache_size_in_gb    = 6144
  sku_name            = "Standard_2G"
  subnet_id           = "/subscriptions/xxx/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-hpc/subnets/snet-hpccache"

  # Enable managed identity for Key Vault access
  identity = {
    type = "UserAssigned"
    identity_ids = [
      "/subscriptions/xxx/resourceGroups/rg-identity/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-hpccache"
    ]
  }

  # Customer-managed key encryption
  key_vault_key_id                           = "https://kv-hpc.vault.azure.net/keys/hpccache-key/abc123"
  automatically_rotate_key_to_latest_enabled = true

  tags = {
    Environment = "Production"
    Compliance  = "HIPAA"
  }
}
```

### Example with Active Directory Integration

```hcl
module "hpc_cache" {
  source = "../../"

  resource_group_name = "rg-hpc-workload"
  location            = "eastus"
  name                = "hpccache-ad"
  cache_size_in_gb    = 12288
  sku_name            = "Standard_4G"
  subnet_id           = "/subscriptions/xxx/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-hpc/subnets/snet-hpccache"

  # Active Directory configuration
  directory_active_directory = {
    dns_primary_ip      = "10.0.1.4"
    dns_secondary_ip    = "10.0.1.5"
    domain_name         = "corp.contoso.com"
    cache_netbios_name  = "HPCCACHE"
    domain_netbios_name = "CORP"
    username            = "svc_hpccache"
    password            = var.ad_password
  }

  tags = {
    Environment = "Production"
    Project     = "HPC-Workload"
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
| [azurerm_hpc_cache.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/hpc_cache) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether resources should be created. | `bool` | `true` | no |
| resource_group_name | The name of the resource group in which to create the HPC Cache. | `string` | n/a | yes |
| location | The Azure region where the HPC Cache should be created. | `string` | n/a | yes |
| name | The name of the HPC Cache. If provided, overrides the generated name. | `string` | `null` | no |
| name_prefix | Prefix for the generated HPC Cache name. | `string` | `"hpc"` | no |
| workload | The workload name for the HPC Cache. | `string` | `null` | no |
| environment | The environment name (e.g., dev, staging, prod). | `string` | `null` | no |
| instance | The instance identifier for the HPC Cache. | `string` | `null` | no |
| tags | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| cache_size_in_gb | The size of the HPC Cache in GB. Valid values: 3072, 6144, 12288, 21623, 24576, 43246, 49152, 86491. | `number` | n/a | yes |
| sku_name | The SKU of the HPC Cache. Valid values: Standard_2G, Standard_4G, Standard_8G, Standard_L4_5G, Standard_L9G, Standard_L16G. | `string` | n/a | yes |
| subnet_id | The ID of the subnet where the HPC Cache will be deployed. Must have Microsoft.StorageCache service endpoint. | `string` | n/a | yes |
| mtu | The MTU setting for the HPC Cache. Valid range: 576-1500. | `number` | `1500` | no |
| ntp_server | The NTP server IP address or FQDN for the HPC Cache. | `string` | `"time.windows.com"` | no |
| dns | DNS configuration with servers list and optional search_domain. | `object` | `null` | no |
| default_access_policy | List of access rules for the default access policy. | `list(object)` | `null` | no |
| identity | Managed identity configuration with type and optional identity_ids. | `object` | `null` | no |
| key_vault_key_id | The ID of the Key Vault Key for customer-managed key encryption. | `string` | `null` | no |
| automatically_rotate_key_to_latest_enabled | Whether to automatically rotate the customer-managed key. | `bool` | `false` | no |
| directory_active_directory | Active Directory configuration for the HPC Cache. | `object` | `null` | no |
| directory_flat_file | Flat file directory configuration for the HPC Cache. | `object` | `null` | no |
| directory_ldap | LDAP directory configuration for the HPC Cache. | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the HPC Cache. |
| name | The name of the HPC Cache. |
| mount_addresses | A list of IP addresses used by clients to mount the HPC Cache. |

## Dependencies

Before using this module, ensure the following resources exist:

1. **Resource Group**: The resource group specified in `resource_group_name` must exist.
2. **Virtual Network and Subnet**: The subnet specified in `subnet_id` must exist and have the `Microsoft.StorageCache` service endpoint enabled.
3. **Key Vault Key** (optional): If using customer-managed key encryption, the Key Vault key specified in `key_vault_key_id` must exist.
4. **User-Assigned Managed Identity** (optional): If using UserAssigned identity type, the identity must exist.

## Subnet Requirements

The subnet used for HPC Cache must meet the following requirements:

- Have at least a /24 CIDR block (256 addresses) or /28 minimum
- Have the `Microsoft.StorageCache` service endpoint enabled
- Not have any Network Security Groups (NSGs) that block HPC Cache traffic
- Be dedicated to the HPC Cache (no other resources)

Example subnet configuration:

```hcl
resource "azurerm_subnet" "hpc_cache" {
  name                 = "snet-hpccache"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.100.0/24"]

  service_endpoints = ["Microsoft.StorageCache"]
}
```

## SKU and Cache Size Combinations

| SKU | Supported Cache Sizes (GB) | Throughput |
|-----|---------------------------|------------|
| Standard_2G | 3072, 6144, 12288 | 2 GB/s |
| Standard_4G | 6144, 12288, 24576 | 4 GB/s |
| Standard_8G | 12288, 24576, 49152 | 8 GB/s |
| Standard_L4_5G | 21623, 43246, 86491 | 4.5 GB/s |
| Standard_L9G | 21623, 43246, 86491 | 9 GB/s |
| Standard_L16G | 21623, 43246, 86491 | 16 GB/s |

## License

This module is licensed under the MIT License.
