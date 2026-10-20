################################################################################
# Entra ID Conditional Access Policy
################################################################################

resource "azuread_conditional_access_policy" "this" {
  count = var.create ? 1 : 0

  display_name = var.display_name
  state        = var.state

  conditions {
    client_app_types    = var.conditions_client_app_types
    sign_in_risk_levels = var.conditions_sign_in_risk_levels
    user_risk_levels    = var.conditions_user_risk_levels

    applications {
      included_applications = var.conditions_applications.included_applications
      excluded_applications = var.conditions_applications.excluded_applications
      included_user_actions = var.conditions_applications.included_user_actions
    }

    users {
      included_users  = var.conditions_users.included_users
      excluded_users  = var.conditions_users.excluded_users
      included_groups = var.conditions_users.included_groups
      excluded_groups = var.conditions_users.excluded_groups
      included_roles  = var.conditions_users.included_roles
      excluded_roles  = var.conditions_users.excluded_roles
    }

    dynamic "platforms" {
      for_each = var.conditions_platforms != null ? [var.conditions_platforms] : []
      content {
        included_platforms = platforms.value.included_platforms
        excluded_platforms = platforms.value.excluded_platforms
      }
    }

    dynamic "locations" {
      for_each = var.conditions_locations != null ? [var.conditions_locations] : []
      content {
        included_locations = locations.value.included_locations
        excluded_locations = locations.value.excluded_locations
      }
    }
  }

  grant_controls {
    operator                          = var.grant_controls.operator
    built_in_controls                 = var.grant_controls.built_in_controls
    custom_authentication_factors     = var.grant_controls.custom_authentication_factors
    terms_of_use                      = var.grant_controls.terms_of_use
    authentication_strength_policy_id = var.grant_controls.authentication_strength_policy_id
  }

  dynamic "session_controls" {
    for_each = var.session_controls != null ? [var.session_controls] : []
    content {
      application_enforced_restrictions_enabled = session_controls.value.application_enforced_restrictions_enabled
      cloud_app_security_policy                 = session_controls.value.cloud_app_security_policy
      disable_resilience_defaults               = session_controls.value.disable_resilience_defaults
      persistent_browser_mode                   = session_controls.value.persistent_browser_mode
      sign_in_frequency                         = session_controls.value.sign_in_frequency
      sign_in_frequency_period                  = session_controls.value.sign_in_frequency_period
      sign_in_frequency_authentication_type     = session_controls.value.sign_in_frequency_authentication_type
      sign_in_frequency_interval                = session_controls.value.sign_in_frequency_interval
    }
  }
}
