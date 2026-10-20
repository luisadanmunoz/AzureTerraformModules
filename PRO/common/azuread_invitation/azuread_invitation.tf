#############################################################################
# MODULE AZUREAD INVITATION
#############################################################################

resource "azuread_invitation" "invitation" {
  user_display_name  = var.user_display_name
  user_email_address = var.user_email_address
  redirect_url       = "https://portal.azure.com"

  message {
    additional_recipients = [var.user_email_address]
    body                  = "¡Hola a todos! Te invito a unirte al inquilino de Evolutio Azure ARC!. Acepta la invitación, entra en la url https://portal.azure.com y Activa MFA siguiendo las indicaciones de Microsoft"
  }
}

#############################################################################
# DATA AZUREAD USER
#############################################################################

data "azuread_user" "invited_user" {

  user_principal_name = "${var.user_principal_name}#EXT#@evolutiohybridcloud.onmicrosoft.com"

  depends_on = [azuread_invitation.invitation]
}

#############################################################################
# MODULE AZUREAD GROUP MEMBER
#############################################################################

resource "azuread_group_member" "member" {
  group_object_id  = var.group_object_id
  member_object_id = data.azuread_user.invited_user.object_id

  depends_on = [azuread_invitation.invitation]
}

