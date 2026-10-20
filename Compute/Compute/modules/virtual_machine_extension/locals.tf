locals {
  settings = var.settings == null ? null : (
    can(keys(var.settings)) ? jsonencode(var.settings) : tostring(var.settings)
  )

  protected_settings = var.protected_settings == null ? null : (
    can(keys(var.protected_settings)) ? jsonencode(var.protected_settings) : tostring(var.protected_settings)
  )
}
