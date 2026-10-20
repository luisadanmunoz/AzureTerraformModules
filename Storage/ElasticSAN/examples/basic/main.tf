################################################################################
# Provider Configuration
################################################################################

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

################################################################################
# Resource Group
################################################################################

resource "azurerm_resource_group" "this" {
  name     = "rg-elasticsan-example"
  location = "eastus"
}

################################################################################
# Elastic SAN Module - Basic Example
################################################################################

module "elastic_san" {
  source = "../../"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  # Naming
  name_prefix = "esan"
  workload    = "app"
  environment = "dev"
  instance    = "001"

  # Elastic SAN Configuration
  sku = {
    name = "Premium_LRS"
  }

  base_size_in_tib     = 1
  extended_size_in_tib = 0

  # Volume Groups
  volume_groups = {
    primary = {
      name            = "vg-primary"
      encryption_type = "EncryptionAtRestWithPlatformKey"
      protocol_type   = "Iscsi"
    }
  }

  # Volumes
  volumes = {
    data = {
      volume_group_key = "primary"
      name             = "vol-data"
      size_in_gib      = 100
    }
    logs = {
      volume_group_key = "primary"
      name             = "vol-logs"
      size_in_gib      = 50
    }
  }

  tags = {
    example     = "basic"
    environment = "development"
  }
}

################################################################################
# Outputs
################################################################################

output "elastic_san_id" {
  description = "The ID of the Elastic SAN."
  value       = module.elastic_san.id
}

output "elastic_san_name" {
  description = "The name of the Elastic SAN."
  value       = module.elastic_san.name
}

output "total_iops" {
  description = "The total IOPS of the Elastic SAN."
  value       = module.elastic_san.total_iops
}

output "total_mbps" {
  description = "The total throughput in MBps."
  value       = module.elastic_san.total_mbps
}

output "volume_group_ids" {
  description = "The IDs of the volume groups."
  value       = module.elastic_san.volume_group_ids
}

output "volumes" {
  description = "The volume details including target IQN."
  value       = module.elastic_san.volumes
}
