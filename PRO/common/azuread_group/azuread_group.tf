#############################################################################
# MODULE AZUREAD GROUP
#############################################################################

resource "azuread_group" "group" {
  display_name     = var.group_name
  owners           = var.owners
  security_enabled = true

}

