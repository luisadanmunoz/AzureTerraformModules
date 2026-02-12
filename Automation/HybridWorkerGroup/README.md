# Azure Automation Hybrid Worker Group Module

Terraform module to create and manage **Azure Automation Hybrid Runbook Worker Groups** for running runbooks on-premises or on Azure VMs.

## Features

- Create Hybrid Worker Groups
- Add Azure VMs as Hybrid Workers
- Associate credentials for worker authentication
- Multiple groups and workers in a single call
- Conditional creation with `create = true/false`

## Usage - Create Hybrid Worker Group

```hcl
module "hybrid_worker_group" {
  source = "path/to/Automation/HybridWorkerGroup"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  hybrid_worker_groups = {
    "OnPremWorkers" = {}
    "AzureVMWorkers" = {}
  }
}
```

## Usage - With Credential

```hcl
# First create a credential
module "automation_credential" {
  source = "../AutomationCredential"

  resource_group_name     = "rg-automation-prod-001"
  automation_account_name = "aa-runbooks-prod-001"

  credentials = {
    "WorkerCredential" = {
      username    = "DOMAIN\\svc-automation"
      password    = var.worker_password
      description = "Credential for Hybrid Workers"
    }
  }
}

# Then create the group with credential
module "hybrid_worker_group" {
  source = "path/to/Automation/HybridWorkerGroup"

  resource_group_name     = "rg-automation-prod-001"
  automation_account_name = "aa-runbooks-prod-001"

  hybrid_worker_groups = {
    "OnPremWorkers" = {
      credential_name = "WorkerCredential"
    }
  }

  depends_on = [module.automation_credential]
}
```

## Usage - With Azure VM Workers

```hcl
module "hybrid_workers" {
  source = "path/to/Automation/HybridWorkerGroup"

  resource_group_name     = "rg-automation-prod-001"
  automation_account_name = "aa-runbooks-prod-001"

  hybrid_worker_groups = {
    "AzureVMWorkers" = {}
  }

  hybrid_workers = {
    "worker-vm-01" = {
      group_name     = "AzureVMWorkers"
      vm_resource_id = "/subscriptions/xxx/resourceGroups/rg-vms/providers/Microsoft.Compute/virtualMachines/vm-worker-01"
    }
    "worker-vm-02" = {
      group_name     = "AzureVMWorkers"
      vm_resource_id = "/subscriptions/xxx/resourceGroups/rg-vms/providers/Microsoft.Compute/virtualMachines/vm-worker-02"
    }
  }
}
```

## Usage - Multiple Groups with Workers

```hcl
module "hybrid_workers" {
  source = "path/to/Automation/HybridWorkerGroup"

  resource_group_name     = "rg-automation-prod-001"
  automation_account_name = "aa-runbooks-prod-001"

  hybrid_worker_groups = {
    "WindowsWorkers" = {
      credential_name = "WindowsCredential"
    }
    "LinuxWorkers" = {}
  }

  hybrid_workers = {
    "win-worker-01" = {
      group_name     = "WindowsWorkers"
      vm_resource_id = azurerm_windows_virtual_machine.worker1.id
    }
    "linux-worker-01" = {
      group_name     = "LinuxWorkers"
      vm_resource_id = azurerm_linux_virtual_machine.worker1.id
    }
  }
}
```

## VM Extension Installation

Before adding a VM as a Hybrid Worker, you must install the Hybrid Worker extension:

### Windows VM

```hcl
resource "azurerm_virtual_machine_extension" "hybrid_worker" {
  name                 = "HybridWorkerExtension"
  virtual_machine_id   = azurerm_windows_virtual_machine.worker.id
  publisher            = "Microsoft.Azure.Automation.HybridWorker"
  type                 = "HybridWorkerForWindows"
  type_handler_version = "1.1"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    AutomationAccountURL = azurerm_automation_account.main.dsc_server_endpoint
  })
}
```

### Linux VM

```hcl
resource "azurerm_virtual_machine_extension" "hybrid_worker" {
  name                 = "HybridWorkerExtension"
  virtual_machine_id   = azurerm_linux_virtual_machine.worker.id
  publisher            = "Microsoft.Azure.Automation.HybridWorker"
  type                 = "HybridWorkerForLinux"
  type_handler_version = "1.1"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    AutomationAccountURL = azurerm_automation_account.main.dsc_server_endpoint
  })
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create resources | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `automation_account_name` | Name of the Automation Account | `string` | - | yes |
| `hybrid_worker_groups` | Map of Hybrid Worker Groups | `map(object)` | `{}` | no |
| `hybrid_workers` | Map of Hybrid Workers (VMs) | `map(object)` | `{}` | no |

### Hybrid Worker Group Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `credential_name` | Credential name for the workers | `string` | no |

### Hybrid Worker Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `group_name` | Name of the Hybrid Worker Group | `string` | yes |
| `vm_resource_id` | Azure Resource ID of the VM | `string` | yes |

## Outputs

| Name | Description |
|------|-------------|
| `group_ids` | Map of group names to their IDs |
| `group_names` | List of created group names |
| `worker_ids` | Map of worker keys to their IDs |
| `worker_ips` | Map of worker keys to their IP addresses |
| `worker_last_seen` | Map of worker keys to their last seen timestamps |

## Dependencies

- **Resource Group** must exist
- **Automation Account** must exist
- **Credential** must exist if `credential_name` is specified
- **VM** must exist with Hybrid Worker extension installed before adding as worker
