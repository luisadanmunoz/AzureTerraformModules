################################################################################
# Elastic SAN Outputs
################################################################################

output "id" {
  description = "The ID of the Elastic SAN."
  value       = var.create ? azurerm_elastic_san.this[0].id : null
}

output "name" {
  description = "The name of the Elastic SAN."
  value       = var.create ? azurerm_elastic_san.this[0].name : null
}

output "total_iops" {
  description = "The total IOPS of the Elastic SAN."
  value       = var.create ? azurerm_elastic_san.this[0].total_iops : null
}

output "total_mbps" {
  description = "The total throughput in MBps of the Elastic SAN."
  value       = var.create ? azurerm_elastic_san.this[0].total_mbps : null
}

output "total_size_in_tib" {
  description = "The total size in TiB of the Elastic SAN."
  value       = var.create ? azurerm_elastic_san.this[0].total_size_in_tib : null
}

output "total_volume_size_in_gib" {
  description = "The total volume size in GiB of the Elastic SAN."
  value       = var.create ? azurerm_elastic_san.this[0].total_volume_size_in_gib : null
}

################################################################################
# Volume Group Outputs
################################################################################

output "volume_group_ids" {
  description = "A map of volume group names to their IDs."
  value = {
    for k, v in azurerm_elastic_san_volume_group.this :
    k => v.id
  }
}

output "volume_groups" {
  description = "A map of volume group details."
  value = {
    for k, v in azurerm_elastic_san_volume_group.this :
    k => {
      id              = v.id
      name            = v.name
      encryption_type = v.encryption_type
      protocol_type   = v.protocol_type
    }
  }
}

################################################################################
# Volume Outputs
################################################################################

output "volume_ids" {
  description = "A map of volume names to their IDs."
  value = {
    for k, v in azurerm_elastic_san_volume.this :
    k => v.id
  }
}

output "volumes" {
  description = "A map of volume details."
  value = {
    for k, v in azurerm_elastic_san_volume.this :
    k => {
      id          = v.id
      name        = v.name
      size_in_gib = v.size_in_gib
      target_iqn  = v.target_iqn
    }
  }
}
