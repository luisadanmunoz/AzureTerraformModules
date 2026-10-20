################################################################################
# Logic App Workflow (Consumption)
# DEPENDENCY: Resource Group must exist.
################################################################################

resource "azurerm_logic_app_workflow" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name
  enabled             = var.enabled

  # Workflow Definition
  workflow_schema     = var.workflow_schema
  workflow_version    = var.workflow_version
  workflow_parameters = var.workflow_parameters
  parameters          = var.parameters

  # Integration
  integration_service_environment_id = var.integration_service_environment_id
  logic_app_integration_account_id   = var.logic_app_integration_account_id

  # ──────────────────────────────────────────────────────────────────────────────
  # Identity
  # ──────────────────────────────────────────────────────────────────────────────
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # ──────────────────────────────────────────────────────────────────────────────
  # Access Control
  # ──────────────────────────────────────────────────────────────────────────────
  dynamic "access_control" {
    for_each = var.access_control != null ? [var.access_control] : []
    content {
      dynamic "trigger" {
        for_each = access_control.value.trigger != null ? [access_control.value.trigger] : []
        content {
          allowed_caller_ip_address_range = trigger.value.allowed_caller_ip_address_range
        }
      }

      dynamic "content" {
        for_each = access_control.value.content != null ? [access_control.value.content] : []
        content {
          allowed_caller_ip_address_range = content.value.allowed_caller_ip_address_range
        }
      }

      dynamic "action" {
        for_each = access_control.value.action != null ? [access_control.value.action] : []
        content {
          allowed_caller_ip_address_range = action.value.allowed_caller_ip_address_range
        }
      }

      dynamic "workflow_management" {
        for_each = access_control.value.workflow_management != null ? [access_control.value.workflow_management] : []
        content {
          allowed_caller_ip_address_range = workflow_management.value.allowed_caller_ip_address_range
        }
      }
    }
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      # Workflow definition is typically managed outside of Terraform
      # after initial creation (via Portal, VS Code, etc.)
      parameters,
      workflow_parameters,
    ]
  }
}
