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
| [azurerm_private_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_aaaa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_aaaa_record) | resource |
| [azurerm_private_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_mx_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_mx_record) | resource |
| [azurerm_private_dns_ptr_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_ptr_record) | resource |
| [azurerm_private_dns_srv_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_srv_record) | resource |
| [azurerm_private_dns_txt_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_a_records"></a> [a\_records](#input\_a\_records) | (Optional) Map of A records to create.<br/><br/>Attributes:<br/>  - ttl: Record TTL in seconds.<br/>  - records: List of IPv4 addresses. | <pre>map(object({<br/>    ttl     = optional(number, 300)<br/>    records = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records) | (Optional) Map of AAAA records to create.<br/><br/>Attributes:<br/>  - ttl: Record TTL in seconds.<br/>  - records: List of IPv6 addresses. | <pre>map(object({<br/>    ttl     = optional(number, 300)<br/>    records = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records) | (Optional) Map of CNAME records to create.<br/><br/>Attributes:<br/>  - ttl: Record TTL in seconds.<br/>  - record: The target domain name. | <pre>map(object({<br/>    ttl    = optional(number, 300)<br/>    record = string<br/>  }))</pre> | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Private DNS Zone. | `bool` | `true` | no |
| <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records) | (Optional) Map of MX records to create.<br/><br/>Attributes:<br/>  - ttl: Record TTL in seconds.<br/>  - records: List of MX entries with preference and exchange. | <pre>map(object({<br/>    ttl = optional(number, 300)<br/>    records = list(object({<br/>      preference = number<br/>      exchange   = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Private DNS Zone (e.g., "privatelink.blob.core.windows.net").<br/>Must be a valid DNS zone name. | `string` | n/a | yes |
| <a name="input_ptr_records"></a> [ptr\_records](#input\_ptr\_records) | (Optional) Map of PTR records to create.<br/><br/>Attributes:<br/>  - ttl: Record TTL in seconds.<br/>  - records: List of domain names. | <pre>map(object({<br/>    ttl     = optional(number, 300)<br/>    records = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Private DNS Zone will be created.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_soa_record"></a> [soa\_record](#input\_soa\_record) | (Optional) SOA record configuration for the DNS zone.<br/><br/>Attributes:<br/>  - email: Contact email for the zone.<br/>  - expire\_time: Time before expiry (default: 2419200).<br/>  - minimum\_ttl: Minimum TTL (default: 10).<br/>  - refresh\_time: Refresh time (default: 3600).<br/>  - retry\_time: Retry time (default: 300).<br/>  - ttl: SOA record TTL (default: 3600). | <pre>object({<br/>    email        = string<br/>    expire_time  = optional(number, 2419200)<br/>    minimum_ttl  = optional(number, 10)<br/>    refresh_time = optional(number, 3600)<br/>    retry_time   = optional(number, 300)<br/>    ttl          = optional(number, 3600)<br/>  })</pre> | `null` | no |
| <a name="input_srv_records"></a> [srv\_records](#input\_srv\_records) | (Optional) Map of SRV records to create.<br/><br/>Attributes:<br/>  - ttl: Record TTL in seconds.<br/>  - records: List of SRV entries. | <pre>map(object({<br/>    ttl = optional(number, 300)<br/>    records = list(object({<br/>      priority = number<br/>      weight   = number<br/>      port     = number<br/>      target   = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records) | (Optional) Map of TXT records to create.<br/><br/>Attributes:<br/>  - ttl: Record TTL in seconds.<br/>  - records: List of TXT values. | <pre>map(object({<br/>    ttl     = optional(number, 300)<br/>    records = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_virtual_network_links"></a> [virtual\_network\_links](#input\_virtual\_network\_links) | (Optional) Map of Virtual Network links to create.<br/>DEPENDENCY: Virtual Networks must exist.<br/><br/>Attributes:<br/>  - virtual\_network\_id: The ID of the Virtual Network to link.<br/>  - registration\_enabled: Enable auto-registration of VM records (default: false). | <pre>map(object({<br/>    virtual_network_id    = string<br/>    registration_enabled  = optional(bool, false)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_a_record_fqdns"></a> [a\_record\_fqdns](#output\_a\_record\_fqdns) | Map of A record names to their FQDNs. |
| <a name="output_a_record_ids"></a> [a\_record\_ids](#output\_a\_record\_ids) | Map of A record names to their IDs. |
| <a name="output_cname_record_fqdns"></a> [cname\_record\_fqdns](#output\_cname\_record\_fqdns) | Map of CNAME record names to their FQDNs. |
| <a name="output_cname_record_ids"></a> [cname\_record\_ids](#output\_cname\_record\_ids) | Map of CNAME record names to their IDs. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private DNS Zone. |
| <a name="output_max_number_of_record_sets"></a> [max\_number\_of\_record\_sets](#output\_max\_number\_of\_record\_sets) | The maximum number of record sets allowed. |
| <a name="output_max_number_of_virtual_network_links"></a> [max\_number\_of\_virtual\_network\_links](#output\_max\_number\_of\_virtual\_network\_links) | The maximum number of VNet links allowed. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Private DNS Zone. |
| <a name="output_number_of_record_sets"></a> [number\_of\_record\_sets](#output\_number\_of\_record\_sets) | The number of record sets in the zone. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group. |
| <a name="output_virtual_network_link_ids"></a> [virtual\_network\_link\_ids](#output\_virtual\_network\_link\_ids) | Map of VNet link names to their IDs. |
<!-- END_TF_DOCS -->