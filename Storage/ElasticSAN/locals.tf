locals {
  # Generate name from components if name is not provided
  name_parts = compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance
  ])

  generated_name = join("-", local.name_parts)

  # Use provided name or fall back to generated name
  resource_name = coalesce(var.name, local.generated_name)

  # Default tags applied to all resources
  default_tags = {
    terraform-managed = "true"
    module            = "ElasticSAN"
  }

  # Merge default tags with user-provided tags (user tags take precedence)
  tags = merge(local.default_tags, var.tags)

  # Map volume group keys to their IDs for volume creation
  volume_group_ids = {
    for k, v in azurerm_elastic_san_volume_group.this :
    k => v.id
  }

  # Prepare volumes with their volume group IDs
  volumes_with_group_ids = {
    for k, v in var.volumes :
    k => merge(v, {
      volume_group_id = local.volume_group_ids[v.volume_group_key]
    })
    if var.create && contains(keys(local.volume_group_ids), v.volume_group_key)
  }
}
