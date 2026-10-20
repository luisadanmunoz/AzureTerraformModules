# Azure Arc-enabled Server

Terraform module for registering Azure Arc-enabled servers. This creates the Azure resource representation of an on-premises or multi-cloud server.

## Features

- Register on-premises servers with Azure Arc
- Support for multiple platforms (VMware, HCI, AWS, GCP, etc.)
- System-assigned managed identity
- Centralized management from Azure

## Usage

```hcl
module "arc_server" {
  source = "path/to/Hybrid/ArcServer"

  name                = "server-onprem-001"
  resource_group_name = azurerm_resource_group.arc.name
  location            = "westeurope"
  kind                = "VMware"

  tags = {
    Environment = "Production"
    Location    = "Datacenter-1"
  }
}
```

## Important Notes

- This module creates the Azure resource for an Arc-enabled server
- The actual onboarding requires running the Azure Connected Machine agent on the server
- Use the Azure Portal or `azcmagent` CLI to complete the onboarding process

## Onboarding Process

1. Create the Arc server resource using this module
2. Download the onboarding script from Azure Portal
3. Run the script on the target server to install the Connected Machine agent
4. The agent will connect to Azure and complete the registration

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Arc-enabled server | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| kind | Machine kind (HCI, SCVMM, VMware, AWS, GCP) | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| identity_type | Managed identity type | `string` | `"SystemAssigned"` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The resource ID |
| name | The resource name |
| identity | The identity block |
| principal_id | The system-assigned identity principal ID |

## Best Practices

1. **Naming**: Use consistent naming that identifies the physical server
2. **Tags**: Add location, environment, and owner tags
3. **Resource Groups**: Group Arc servers by location or purpose
4. **RBAC**: Use the managed identity for Azure resource access
