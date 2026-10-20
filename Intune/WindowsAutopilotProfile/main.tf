################################################################################
# Microsoft Intune Windows Autopilot Deployment Profile
################################################################################

resource "microsoft365_windows_autopilot_deployment_profile" "this" {
  count = var.create ? 1 : 0

  display_name         = var.display_name
  description          = var.description
  device_name_template = var.device_name_template
  device_type          = var.device_type
  enable_white_glove   = var.enable_white_glove

  # Language and region
  language            = var.language
  keyboard_identifier = var.keyboard_identifier

  # OOBE settings
  out_of_box_experience_settings {
    hide_eula                    = try(var.oobe_settings.hide_eula, true)
    hide_privacy_settings        = try(var.oobe_settings.hide_privacy_settings, true)
    hide_change_account_options  = try(var.oobe_settings.hide_change_account_options, true)
    user_type                    = try(var.oobe_settings.user_type, "standard")
    device_usage_type            = try(var.oobe_settings.device_usage_type, "singleUser")
    skip_keyboard_selection_page = try(var.oobe_settings.skip_keyboard_selection_page, true)
    hide_escape_link             = try(var.oobe_settings.hide_escape_link, true)
  }

  # Enrollment Status Page settings
  enrollment_status_page_settings {
    show_progress                               = try(var.enrollment_status_page.show_progress, true)
    block_device_use_until_profile_complete     = try(var.enrollment_status_page.block_device_use_until_profile_complete, true)
    allow_device_use_on_error                   = try(var.enrollment_status_page.allow_device_use_on_error, false)
    allow_log_collection_on_error               = try(var.enrollment_status_page.allow_log_collection_on_error, true)
    allow_device_reset_on_error                 = try(var.enrollment_status_page.allow_device_reset_on_error, false)
    allow_retry                                 = try(var.enrollment_status_page.allow_retry, true)
    custom_error_message                        = try(var.enrollment_status_page.custom_error_message, null)
    show_installation_progress                  = try(var.enrollment_status_page.show_installation_progress, true)
    install_progress_timeout_in_minutes         = try(var.enrollment_status_page.install_progress_timeout_in_minutes, 60)
    track_install_progress_for_autpilot_only    = try(var.enrollment_status_page.track_install_progress_for_autpilot_only, true)
    disable_user_status_tracking_after_first_user = try(var.enrollment_status_page.disable_user_status_tracking_after_first_user, false)
  }

  # Hybrid Azure AD Join (if enabled)
  dynamic "hybrid_azure_ad_join_settings" {
    for_each = try(var.hybrid_azure_ad_join.enabled, false) ? [1] : []
    content {
      domain_join_connector = var.hybrid_azure_ad_join.domain_join_connector
      ou_path               = var.hybrid_azure_ad_join.ou_path
    }
  }

  # Assignments
  dynamic "assignment" {
    for_each = var.assignments
    content {
      target_type = assignment.value.target_type
      group_id    = assignment.value.group_id
      filter_id   = assignment.value.filter_id
      filter_type = assignment.value.filter_type
    }
  }
}
