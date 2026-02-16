################################################################################
# Entra ID Application Password (Client Secret)
################################################################################

resource "azuread_application_password" "this" {
  count = var.create ? 1 : 0

  application_id = var.application_id

  display_name      = var.display_name
  end_date          = var.end_date
  end_date_relative = var.end_date_relative
  start_date        = var.start_date
  rotate_when_changed = var.rotate_when_changed
}
