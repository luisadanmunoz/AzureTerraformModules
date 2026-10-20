# Azure ML Compute Instance

Terraform module for creating Azure ML Compute Instances for development.

## Features

- Personal compute for data scientists
- SSH access support
- VNet integration
- User assignment

## Usage

```hcl
module "compute_instance" {
  source = "path/to/IA/MLComputeInstance"

  name                          = "ci-dev-001"
  machine_learning_workspace_id = module.ml_workspace.id
  virtual_machine_size          = "Standard_DS3_v2"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Instance name | `string` | n/a | yes |
| machine_learning_workspace_id | ML Workspace ID | `string` | n/a | yes |
| virtual_machine_size | VM size | `string` | n/a | yes |
| node_public_ip_enabled | Public IP | `bool` | `true` | no |
| subnet_resource_id | Subnet ID | `string` | `null` | no |
| ssh | SSH config | `object` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The instance ID |
| name | The instance name |

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
| [azurerm_machine_learning_compute_instance.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_assign_to_user"></a> [assign\_to\_user](#input\_assign\_to\_user) | Assign the compute instance to a specific user. | <pre>object({<br/>    object_id = string<br/>    tenant_id = string<br/>  })</pre> | `null` | no |
| <a name="input_authorization_type"></a> [authorization\_type](#input\_authorization\_type) | The authorization type. Possible values: personal. | `string` | `"personal"` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the compute instance. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the compute instance. | `string` | `null` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | Whether local authentication is enabled. | `bool` | `true` | no |
| <a name="input_machine_learning_workspace_id"></a> [machine\_learning\_workspace\_id](#input\_machine\_learning\_workspace\_id) | The ID of the Machine Learning Workspace. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the compute instance. | `string` | n/a | yes |
| <a name="input_node_public_ip_enabled"></a> [node\_public\_ip\_enabled](#input\_node\_public\_ip\_enabled) | Whether the compute instance has a public IP. | `bool` | `true` | no |
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration for the compute instance. | <pre>object({<br/>    public_key = string<br/>  })</pre> | `null` | no |
| <a name="input_subnet_resource_id"></a> [subnet\_resource\_id](#input\_subnet\_resource\_id) | The subnet resource ID for the compute instance. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | The VM size (e.g., Standard\_DS3\_v2). | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the compute instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the compute instance. |
<!-- END_TF_DOCS -->