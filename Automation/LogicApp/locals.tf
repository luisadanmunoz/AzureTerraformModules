locals {
  # ──────────────────────────────────────────────────────────────────────────────
  # Naming Convention
  # ──────────────────────────────────────────────────────────────────────────────
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name

  # ──────────────────────────────────────────────────────────────────────────────
  # Tags
  # ──────────────────────────────────────────────────────────────────────────────
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "LogicApp"
  }
  tags = merge(local.default_tags, var.tags)

  # ──────────────────────────────────────────────────────────────────────────────
  # Default empty workflow definition
  # ──────────────────────────────────────────────────────────────────────────────
  default_workflow_definition = jsonencode({
    "$schema"        = var.workflow_schema
    "contentVersion" = var.workflow_version
    "triggers"       = {}
    "actions"        = {}
    "outputs"        = {}
  })

  workflow_definition = var.workflow_definition != null ? var.workflow_definition : local.default_workflow_definition
}
