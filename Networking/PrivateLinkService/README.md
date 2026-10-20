# Azure Private Link Service Terraform Module

This module creates an Azure Private Link Service for exposing services privately to consumers
via Azure Private Endpoints across subscriptions and tenants.

## Features

- Private Link Service creation backed by a Standard Load Balancer
- NAT IP configuration with support for multiple NAT IPs
- Auto-approval and visibility controls per subscription
- Proxy Protocol support for preserving client connection information
- Custom FQDN association
- Flexible naming convention

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Standard Load Balancer | **Yes** | Must exist with at least one frontend IP configuration |
| Subnet | **Yes** | Must have private link service network policies disabled |

## Usage

### Basic Private Link Service

```hcl
module "private_link_service" {
  source = "../../Networking/PrivateLinkService"

  resource_group_name = "rg-networking-dev-001"
  location            = "westeurope"

  name = "pls-myapp-dev-001"

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.example.frontend_ip_configuration[0].id
  ]

  nat_ip_configuration = [
    {
      name      = "nat-primary"
      subnet_id = azurerm_subnet.pls.id
      primary   = true
    }
  ]
}
```

### With Auto-Approval and Visibility

```hcl
module "private_link_service" {
  source = "../../Networking/PrivateLinkService"

  resource_group_name = "rg-networking-prod-001"
  location            = "westeurope"

  name = "pls-myapp-prod-001"

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.example.frontend_ip_configuration[0].id
  ]

  nat_ip_configuration = [
    {
      name      = "nat-primary"
      subnet_id = azurerm_subnet.pls.id
      primary   = true
    },
    {
      name      = "nat-secondary"
      subnet_id = azurerm_subnet.pls.id
      primary   = false
    }
  ]

  auto_approval_subscription_ids = [
    "00000000-0000-0000-0000-000000000001",
    "00000000-0000-0000-0000-000000000002"
  ]

  visibility_subscription_ids = [
    "00000000-0000-0000-0000-000000000001",
    "00000000-0000-0000-0000-000000000002",
    "00000000-0000-0000-0000-000000000003"
  ]

  enable_proxy_protocol = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit name | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"pls"` | no |
| name_suffix | Suffix for generated name | `string` | `""` | no |
| workload | Workload name for naming convention | `string` | `"default"` | no |
| environment | Environment name | `string` | `"dev"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| load_balancer_frontend_ip_configuration_ids | Frontend IP Configuration IDs from a Standard LB | `list(string)` | n/a | **yes** |
| nat_ip_configuration | NAT IP configuration blocks | `list(object({...}))` | n/a | **yes** |
| auto_approval_subscription_ids | Subscription IDs for auto-approval | `list(string)` | `null` | no |
| visibility_subscription_ids | Subscription IDs for visibility | `list(string)` | `null` | no |
| enable_proxy_protocol | Enable Proxy Protocol | `bool` | `false` | no |
| fqdns | FQDNs for the Private Link Service | `list(string)` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Private Link Service ID |
| name | Private Link Service name |
| alias | Private Link Service alias (used by consumers to connect) |

## Architecture Notes

1. **Standard Load Balancer**: Private Link Service requires a Standard SKU Load Balancer
2. **NAT Subnet**: The subnet used for NAT IP configuration must have `private_link_service_network_policies_enabled` set to `false`
3. **Primary NAT IP**: Exactly one NAT IP configuration must be marked as primary
4. **Proxy Protocol**: Enable when you need to preserve the original client IP address
5. **Alias**: The alias output is used by consumers to create Private Endpoint connections to this service

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
| [azurerm_private_link_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_link_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_approval_subscription_ids"></a> [auto\_approval\_subscription\_ids](#input\_auto\_approval\_subscription\_ids) | (Optional) A list of Subscription IDs that are automatically approved to connect to the Private Link Service. | `list(string)` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Private Link Service. | `bool` | `true` | no |
| <a name="input_enable_proxy_protocol"></a> [enable\_proxy\_protocol](#input\_enable\_proxy\_protocol) | (Optional) Whether to enable the Proxy Protocol on the Private Link Service. Defaults to false. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"dev"` | no |
| <a name="input_fqdns"></a> [fqdns](#input\_fqdns) | (Optional) A list of FQDNs associated with the Private Link Service. | `list(string)` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_load_balancer_frontend_ip_configuration_ids"></a> [load\_balancer\_frontend\_ip\_configuration\_ids](#input\_load\_balancer\_frontend\_ip\_configuration\_ids) | (Required) A list of Frontend IP Configuration IDs from a Standard Load Balancer<br/>that this Private Link Service will be associated with.<br/>DEPENDENCY: Standard Load Balancer with frontend IP configuration(s) must exist. | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the Private Link Service will be deployed.<br/>DEPENDENCY: Should match the Resource Group location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Private Link Service. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"pls"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix for generated name. | `string` | `""` | no |
| <a name="input_nat_ip_configuration"></a> [nat\_ip\_configuration](#input\_nat\_ip\_configuration) | (Required) One or more NAT IP configuration blocks for the Private Link Service.<br/>Exactly one must be marked as primary.<br/>DEPENDENCY: Subnet(s) must exist with private link service network policies disabled.<br/><br/>Attributes:<br/>  - name: The name of the NAT IP configuration.<br/>  - subnet\_id: The ID of the Subnet to use for NAT IP configuration.<br/>  - primary: Whether this is the primary NAT IP configuration.<br/>  - private\_ip\_address: (Optional) A static private IP address for the NAT IP configuration.<br/>  - private\_ip\_address\_version: (Optional) The IP version for the private IP address (IPv4 or IPv6). Defaults to IPv4. | <pre>list(object({<br/>    name                       = string<br/>    subnet_id                  = string<br/>    primary                    = bool<br/>    private_ip_address         = optional(string, null)<br/>    private_ip_address_version = optional(string, "IPv4")<br/>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Private Link Service will be created.<br/>DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_visibility_subscription_ids"></a> [visibility\_subscription\_ids](#input\_visibility\_subscription\_ids) | (Optional) A list of Subscription IDs that are allowed to see the Private Link Service. | `list(string)` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for naming convention. | `string` | `"default"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alias"></a> [alias](#output\_alias) | The alias of the Private Link Service, used by consumers to create a connection. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Private Link Service. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Private Link Service. |
<!-- END_TF_DOCS -->