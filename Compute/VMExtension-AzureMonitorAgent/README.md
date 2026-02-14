# VMExtension-AzureMonitorAgent

Terraform module for deploying Azure Monitor Agent on VMs.

## Features

- Linux and Windows support
- Data Collection Rule association
- System or User Assigned Identity authentication
- Automatic extension upgrades

## Usage

```hcl
module "ama" {
  source = "./Compute/VMExtension-AzureMonitorAgent"

  virtual_machine_id      = module.vm.id
  os_type                 = "Linux"
  data_collection_rule_id = azurerm_monitor_data_collection_rule.main.id
}
```

## Requirements

- VM must have a Managed Identity (System or User Assigned)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| virtual_machine_id | VM ID | `string` | n/a | yes |
| os_type | Linux or Windows | `string` | n/a | yes |
| data_collection_rule_id | DCR ID | `string` | `null` | no |
| user_assigned_identity_id | User Identity | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Extension ID |
| dcr_association_id | DCR Association ID |
