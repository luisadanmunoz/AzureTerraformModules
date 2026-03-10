################################################################################
# Entra ID Application Certificate
################################################################################

resource "azuread_application_certificate" "this" {
  count = var.create ? 1 : 0

  application_id = var.application_id
  value          = var.value
  encoding       = var.encoding
  type           = var.type

  key_id            = var.key_id
  start_date        = var.start_date
  end_date          = var.end_date
  end_date_relative = var.end_date_relative
}
