# Azure NAT Gateway Terraform Module

This module creates an Azure NAT Gateway with optional Public IP creation and associations.

## Features

- Automatic Public IP creation (optional)
- Public IP and Public IP Prefix associations
- Zone configuration
- Idle timeout configuration
- Flexible naming convention

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist before creating the NAT Gateway |
| Public IP | No | If providing existing IPs (must be Standard SKU, Static) |
| Public IP Prefix | No | If using IP prefixes for SNAT |
| Subnet | No | Subnet association done via Subnet module |

## Usage

### Basic Example (Auto-creates Public IP)

```hcl
module "nat_gateway" {
  source = "../../Networking/NATGateway"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name = "ng-spoke-dev-001"
}
```

### With Existing Public IPs

```hcl
module "nat_gateway" {
  source = "../../Networking/NATGateway"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  name             = "ng-spoke-prod-001"
  create_public_ip = false
  public_ip_ids    = [module.pip1.id, module.pip2.id]
}
```

### Zone-Specific

```hcl
module "nat_gateway" {
  source = "../../Networking/NATGateway"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  name  = "ng-zone1-prod-001"
  zones = ["1"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| sku_name | SKU name (Standard only) | `string` | `"Standard"` | no |
| idle_timeout_in_minutes | Idle timeout (4-120) | `number` | `4` | no |
| zones | Availability zones (single) | `list(string)` | `[]` | no |
| create_public_ip | Create a Public IP | `bool` | `true` | no |
| public_ip_ids | Existing Public IP IDs | `list(string)` | `[]` | no |
| public_ip_prefix_ids | Public IP Prefix IDs | `list(string)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the NAT Gateway |
| name | The name of the NAT Gateway |
| resource_guid | The resource GUID |
| public_ip_id | Created Public IP ID |
| public_ip_address | Created Public IP address |
| all_public_ip_ids | All associated Public IP IDs |

## Notes

- NAT Gateway only supports a single availability zone
- Public IPs must be Standard SKU with Static allocation
- Associate NAT Gateway to subnets using the Subnet module
- Each NAT Gateway supports up to 16 Public IPs

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
| [azurerm_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_nat_gateway_public_ip_prefix_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_prefix_association) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the NAT Gateway. | `bool` | `true` | no |
| <a name="input_create_public_ip"></a> [create\_public\_ip](#input\_create\_public\_ip) | (Optional) Create a new Public IP for the NAT Gateway. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"dev"` | no |
| <a name="input_idle_timeout_in_minutes"></a> [idle\_timeout\_in\_minutes](#input\_idle\_timeout\_in\_minutes) | (Optional) The idle timeout in minutes (4-120). Default is 4. | `number` | `4` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the NAT Gateway will be deployed.<br/>DEPENDENCY: Should match the Resource Group location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the NAT Gateway. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"ng"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix for generated name. | `string` | `""` | no |
| <a name="input_public_ip_ids"></a> [public\_ip\_ids](#input\_public\_ip\_ids) | (Optional) List of existing Public IP IDs to associate with the NAT Gateway.<br/>DEPENDENCY: Public IPs must exist and be Standard SKU, Static allocation. | `list(string)` | `[]` | no |
| <a name="input_public_ip_name"></a> [public\_ip\_name](#input\_public\_ip\_name) | (Optional) Name for the created Public IP. Auto-generated if not provided. | `string` | `null` | no |
| <a name="input_public_ip_prefix_ids"></a> [public\_ip\_prefix\_ids](#input\_public\_ip\_prefix\_ids) | (Optional) List of Public IP Prefix IDs to associate with the NAT Gateway.<br/>DEPENDENCY: Public IP Prefixes must exist. | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the NAT Gateway will be created.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) The SKU name. Only 'Standard' is supported. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for naming convention. | `string` | `"default"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) List of availability zones for the NAT Gateway.<br/>NAT Gateway supports a single zone only (e.g., ["1"]). | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_all_public_ip_ids"></a> [all\_public\_ip\_ids](#output\_all\_public\_ip\_ids) | All Public IP IDs associated with the NAT Gateway. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the NAT Gateway. |
| <a name="output_name"></a> [name](#output\_name) | The name of the NAT Gateway. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The IP address of the created Public IP (if created). |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | The ID of the created Public IP (if created). |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group. |
| <a name="output_resource_guid"></a> [resource\_guid](#output\_resource\_guid) | The resource GUID of the NAT Gateway. |
<!-- END_TF_DOCS -->