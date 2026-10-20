################################################################################
# Automation Runbook
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_runbook" "this" {
  count = var.create ? 1 : 0

  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  runbook_type            = var.runbook_type
  description             = var.description

  log_verbose              = var.log_verbose
  log_progress             = var.log_progress
  log_activity_trace_level = var.log_activity_trace_level

  # ──────────────────────────────────────────────────────────────────────────────
  # Content (inline script)
  # ──────────────────────────────────────────────────────────────────────────────
  content = var.content

  # ──────────────────────────────────────────────────────────────────────────────
  # Publish Content Link (external URI)
  # ──────────────────────────────────────────────────────────────────────────────
  dynamic "publish_content_link" {
    for_each = var.publish_content_link != null ? [var.publish_content_link] : []
    content {
      uri     = publish_content_link.value.uri
      version = publish_content_link.value.version

      dynamic "hash" {
        for_each = publish_content_link.value.hash != null ? [publish_content_link.value.hash] : []
        content {
          algorithm = hash.value.algorithm
          value     = hash.value.value
        }
      }
    }
  }

  # ──────────────────────────────────────────────────────────────────────────────
  # Draft Configuration
  # ──────────────────────────────────────────────────────────────────────────────
  dynamic "draft" {
    for_each = var.draft != null ? [var.draft] : []
    content {
      edit_mode_enabled = draft.value.edit_mode_enabled
      output_types      = draft.value.output_types

      dynamic "content_link" {
        for_each = draft.value.content_link != null ? [draft.value.content_link] : []
        content {
          uri     = content_link.value.uri
          version = content_link.value.version

          dynamic "hash" {
            for_each = content_link.value.hash != null ? [content_link.value.hash] : []
            content {
              algorithm = hash.value.algorithm
              value     = hash.value.value
            }
          }
        }
      }

      dynamic "parameters" {
        for_each = draft.value.parameters
        content {
          key           = parameters.value.key
          type          = parameters.value.type
          mandatory     = parameters.value.mandatory
          position      = parameters.value.position
          default_value = parameters.value.default_value
        }
      }
    }
  }

  tags = local.tags
}

################################################################################
# Job Schedules
# DEPENDENCY: Schedule must exist in the Automation Account.
################################################################################

resource "azurerm_automation_job_schedule" "this" {
  for_each = var.create ? { for idx, js in var.job_schedules : "${var.name}-${js.schedule_name}" => js } : {}

  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  runbook_name            = azurerm_automation_runbook.this[0].name
  schedule_name           = each.value.schedule_name
  parameters              = each.value.parameters
  run_on                  = each.value.run_on
}
