locals {
  # ──────────────────────────────────────────────────────────────────────────────
  # Tags
  # ──────────────────────────────────────────────────────────────────────────────
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "Runbook"
  }
  tags = merge(local.default_tags, var.tags)
}
