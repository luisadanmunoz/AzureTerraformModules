# Azure Private Endpoint Terraform Module

This module creates an Azure Private Endpoint for secure connectivity to Azure PaaS services.

## Features

- Private Endpoint creation for any supported Azure service
- Private DNS Zone integration for automatic DNS registration
- Static IP configuration support
- Manual approval workflow support
- Flexible naming convention

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Subnet | **Yes** | Must have private endpoint network policies disabled |
| Target Resource | **Yes** | The PaaS service to connect to (Storage, SQL, etc.) |
| Private DNS Zone | No | Required for automatic DNS registration |

## Common Subresource Names

| Service | Subresource Names |
|---------|-------------------|
| Storage Account (Blob) | `blob` |
| Storage Account (File) | `file` |
| Storage Account (Queue) | `queue` |
| Storage Account (Table) | `table` |
| Storage Account (Web) | `web` |
| Azure SQL Database | `sqlServer` |
| Azure SQL Managed Instance | `managedInstance` |
| Key Vault | `vault` |
| Azure Cosmos DB (SQL) | `Sql` |
| Azure Container Registry | `registry` |
| Event Hub | `namespace` |
| Service Bus | `namespace` |
| App Configuration | `configurationStores` |

## Usage

### Storage Account Private Endpoint

```hcl
module "pe_storage" {
  source = "../../Networking/PrivateEndpoint"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  subnet_id           = module.subnet_pe.id

  name = "pe-stmyapp-blob"

  private_service_connection = {
    name                           = "psc-stmyapp-blob"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group = {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  }
}
```

### Key Vault Private Endpoint

```hcl
module "pe_keyvault" {
  source = "../../Networking/PrivateEndpoint"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  subnet_id           = module.subnet_pe.id

  name = "pe-kv-myapp"

  private_service_connection = {
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
  }

  private_dns_zone_group = {
    private_dns_zone_ids = [azurerm_private_dns_zone.vault.id]
  }
}
```

### SQL Database Private Endpoint

```hcl
module "pe_sql" {
  source = "../../Networking/PrivateEndpoint"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"
  subnet_id           = module.subnet_pe.id

  name = "pe-sql-myapp"

  private_service_connection = {
    private_connection_resource_id = azurerm_mssql_server.this.id
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group = {
    private_dns_zone_ids = [azurerm_private_dns_zone.sql.id]
  }
}
```

### With Static IP

```hcl
module "pe_storage_static" {
  source = "../../Networking/PrivateEndpoint"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"
  subnet_id           = module.subnet_pe.id

  name = "pe-stmyapp-blob"

  private_service_connection = {
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
  }

  ip_configuration = [{
    name               = "ipconfig-blob"
    subresource_name   = "blob"
    private_ip_address = "10.0.10.100"
  }]

  private_dns_zone_group = {
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| subnet_id | Subnet ID | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| private_service_connection | Service connection config | `object({...})` | n/a | **yes** |
| private_dns_zone_group | DNS zone group config | `object({...})` | `null` | no |
| ip_configuration | Static IP config | `list(object({...}))` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Private Endpoint ID |
| name | Private Endpoint name |
| private_ip_address | Private IP address |
| private_ip_addresses | All private IP addresses |
| fqdn | FQDNs from DNS configs |
| network_interface_id | NIC ID |

## Security Recommendations

1. **Disable public access** on target resources when using private endpoints
2. **Use Private DNS Zones** for seamless name resolution
3. **Network policies**: Keep private endpoint network policies disabled on the subnet
4. **Dedicated subnet**: Use a dedicated subnet for private endpoints

## Private DNS Zone Names

| Service | DNS Zone Name |
|---------|---------------|
| Blob Storage | `privatelink.blob.core.windows.net` |
| File Storage | `privatelink.file.core.windows.net` |
| Queue Storage | `privatelink.queue.core.windows.net` |
| Table Storage | `privatelink.table.core.windows.net` |
| Azure SQL | `privatelink.database.windows.net` |
| Key Vault | `privatelink.vaultcore.azure.net` |
| ACR | `privatelink.azurecr.io` |
| Event Hub | `privatelink.servicebus.windows.net` |
| Cosmos DB | `privatelink.documents.azure.com` |

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
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Private Endpoint. | `bool` | `true` | no |
| <a name="input_custom_network_interface_name"></a> [custom\_network\_interface\_name](#input\_custom\_network\_interface\_name) | (Optional) Custom name for the network interface. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | (Optional) Static IP configuration for the private endpoint.<br/>By default, a dynamic IP is assigned from the subnet.<br/><br/>Attributes:<br/>  - name: Name for the IP configuration.<br/>  - subresource\_name: Subresource name (must match subresource\_names).<br/>  - member\_name: Member name (e.g., "default").<br/>  - private\_ip\_address: Static private IP address. | <pre>list(object({<br/>    name               = string<br/>    subresource_name   = optional(string, null)<br/>    member_name        = optional(string, "default")<br/>    private_ip_address = string<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the Private Endpoint will be deployed.<br/>DEPENDENCY: Should match the Resource Group and Subnet location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Private Endpoint. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"pe"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix for generated name. | `string` | `""` | no |
| <a name="input_private_dns_zone_group"></a> [private\_dns\_zone\_group](#input\_private\_dns\_zone\_group) | (Optional) Private DNS Zone Group configuration for automatic DNS registration.<br/>DEPENDENCY: Private DNS Zone(s) must exist.<br/><br/>Attributes:<br/>  - name: Name for the DNS zone group.<br/>  - private\_dns\_zone\_ids: List of Private DNS Zone IDs. | <pre>object({<br/>    name                 = optional(string, "default")<br/>    private_dns_zone_ids = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_private_service_connection"></a> [private\_service\_connection](#input\_private\_service\_connection) | (Required) The private service connection configuration.<br/>DEPENDENCY: Target resource must exist and support private endpoints.<br/><br/>Attributes:<br/>  - name: A name for the private service connection.<br/>  - private\_connection\_resource\_id: The ID of the resource to connect to.<br/>  - is\_manual\_connection: Whether manual approval is required (false for owned resources).<br/>  - subresource\_names: List of subresource names (e.g., ["blob"], ["sqlServer"]).<br/>  - request\_message: Request message for manual connections. | <pre>object({<br/>    name                           = optional(string, "psc")<br/>    private_connection_resource_id = string<br/>    is_manual_connection           = optional(bool, false)<br/>    subresource_names              = optional(list(string), null)<br/>    request_message                = optional(string, null)<br/>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Private Endpoint will be created.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the Subnet where the Private Endpoint will be created.<br/>DEPENDENCY: Subnet must exist with private endpoint policies disabled. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for naming convention. | `string` | `"default"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDNs from custom DNS configs. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private Endpoint. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Private Endpoint. |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | The ID of the network interface. |
| <a name="output_network_interface_name"></a> [network\_interface\_name](#output\_network\_interface\_name) | The name of the network interface. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address of the Private Endpoint. |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | All private IP addresses of the Private Endpoint. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The ID of the Subnet. |
<!-- END_TF_DOCS -->