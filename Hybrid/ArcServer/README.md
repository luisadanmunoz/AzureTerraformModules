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
| [azurerm_arc_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/arc_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Arc server resource. | `bool` | `true` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. Only SystemAssigned is supported. | `string` | `"SystemAssigned"` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of Arc machine. Possible values: HCI, SCVMM, VMware, EPS, GCP, AWS. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Arc server will be registered. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Arc-enabled server. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Arc-enabled server. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block of the Arc-enabled server. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Arc-enabled server. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned managed identity. |
<!-- END_TF_DOCS -->