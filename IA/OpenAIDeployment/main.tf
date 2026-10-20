################################################################################
# Azure OpenAI Deployment
################################################################################

resource "azurerm_cognitive_deployment" "this" {
  count = var.create ? 1 : 0

  name                   = var.name
  cognitive_account_id   = var.cognitive_account_id
  rai_policy_name        = var.rai_policy_name
  version_upgrade_option = var.version_upgrade_option

  model {
    format  = var.model_format
    name    = var.model_name
    version = var.model_version
  }

  scale {
    type     = var.scale_type
    tier     = var.scale_tier
    size     = var.scale_size
    family   = var.scale_family
    capacity = var.scale_capacity
  }
}
