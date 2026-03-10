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
