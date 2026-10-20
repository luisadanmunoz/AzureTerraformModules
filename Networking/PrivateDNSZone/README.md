# Azure Private DNS Zone Terraform Module

This module creates an Azure Private DNS Zone with optional VNet links and DNS records.

## Features

- Private DNS Zone creation
- Virtual Network links with optional auto-registration
- Support for all DNS record types (A, AAAA, CNAME, MX, PTR, SRV, TXT)
- SOA record configuration
- Flexible tagging

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Virtual Networks | No | Only for VNet links |

## Common Private DNS Zone Names

| Service | Zone Name |
|---------|-----------|
| Blob Storage | `privatelink.blob.core.windows.net` |
| File Storage | `privatelink.file.core.windows.net` |
| Queue Storage | `privatelink.queue.core.windows.net` |
| Table Storage | `privatelink.table.core.windows.net` |
| Web Storage | `privatelink.web.core.windows.net` |
| Azure SQL | `privatelink.database.windows.net` |
| Azure Cosmos DB | `privatelink.documents.azure.com` |
| Key Vault | `privatelink.vaultcore.azure.net` |
| ACR | `privatelink.azurecr.io` |
| Event Hub / Service Bus | `privatelink.servicebus.windows.net` |
| App Configuration | `privatelink.azconfig.io` |
| Azure ML | `privatelink.api.azureml.ms` |

## Usage

### Basic Private DNS Zone

```hcl
module "private_dns_blob" {
  source = "../../Networking/PrivateDNSZone"

  resource_group_name = "rg-networking-dev-001"
  name                = "privatelink.blob.core.windows.net"
}
```

### With VNet Links

```hcl
module "private_dns_blob" {
  source = "../../Networking/PrivateDNSZone"

  resource_group_name = "rg-networking-dev-001"
  name                = "privatelink.blob.core.windows.net"

  virtual_network_links = {
    "link-hub-vnet" = {
      virtual_network_id   = module.hub_vnet.id
      registration_enabled = false
    }
    "link-spoke-vnet" = {
      virtual_network_id   = module.spoke_vnet.id
      registration_enabled = false
    }
  }
}
```

### With Auto-Registration (VM DNS)

```hcl
module "private_dns_internal" {
  source = "../../Networking/PrivateDNSZone"

  resource_group_name = "rg-networking-dev-001"
  name                = "internal.contoso.com"

  virtual_network_links = {
    "link-workloads-vnet" = {
      virtual_network_id   = module.workloads_vnet.id
      registration_enabled = true  # VMs will auto-register
    }
  }
}
```

### With DNS Records

```hcl
module "private_dns_custom" {
  source = "../../Networking/PrivateDNSZone"

  resource_group_name = "rg-networking-dev-001"
  name                = "internal.contoso.com"

  virtual_network_links = {
    "link-main-vnet" = {
      virtual_network_id   = module.main_vnet.id
      registration_enabled = true
    }
  }

  a_records = {
    "app1" = {
      ttl     = 300
      records = ["10.0.1.10"]
    }
    "app2" = {
      ttl     = 300
      records = ["10.0.1.11", "10.0.1.12"]
    }
  }

  cname_records = {
    "www" = {
      ttl    = 300
      record = "app1.internal.contoso.com"
    }
  }

  txt_records = {
    "_verification" = {
      ttl     = 3600
      records = ["verification-token-123"]
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| name | DNS zone name | `string` | n/a | **yes** |
| soa_record | SOA record config | `object({...})` | `null` | no |
| virtual_network_links | VNet links map | `map(object({...}))` | `{}` | no |
| a_records | A records map | `map(object({...}))` | `{}` | no |
| aaaa_records | AAAA records map | `map(object({...}))` | `{}` | no |
| cname_records | CNAME records map | `map(object({...}))` | `{}` | no |
| mx_records | MX records map | `map(object({...}))` | `{}` | no |
| ptr_records | PTR records map | `map(object({...}))` | `{}` | no |
| srv_records | SRV records map | `map(object({...}))` | `{}` | no |
| txt_records | TXT records map | `map(object({...}))` | `{}` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | DNS Zone ID |
| name | DNS Zone name |
| number_of_record_sets | Current record set count |
| virtual_network_link_ids | Map of VNet link IDs |
| a_record_ids | Map of A record IDs |
| a_record_fqdns | Map of A record FQDNs |
| cname_record_ids | Map of CNAME record IDs |

## Best Practices

1. **Centralize DNS zones** in a hub/shared subscription
2. **Link all VNets** that need to resolve private endpoint names
3. **Use auto-registration** only for internal VM DNS, not for Private Link zones
4. **Follow naming conventions** as per Azure documentation for Private Link zones
