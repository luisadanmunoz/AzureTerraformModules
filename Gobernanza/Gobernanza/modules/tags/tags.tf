#############################################################################
# TAGS
#############################################################################
locals {
  tags = merge(
    {
      workload_name       = var.workload_name
      environment         = var.environment
      owner               = var.owner
      cost_center         = var.cost_center
      data_classification = var.data_classification
      criticality         = var.criticality
      managed_by          = var.managed_by
    },
    var.custom_tags
  )
}
