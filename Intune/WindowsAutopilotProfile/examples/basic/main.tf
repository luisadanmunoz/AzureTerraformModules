################################################################################
# Provider Configuration
################################################################################

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    microsoft365 = {
      source  = "terraconfigure/microsoft365"
      version = ">= 0.1.0"
    }
  }
}

provider "microsoft365" {}

################################################################################
# Standard Autopilot Profile
################################################################################

module "autopilot_standard" {
  source = "../../"

  display_name         = "Standard Corporate Autopilot"
  description          = "Standard user-driven deployment profile"
  device_name_template = "CORP-%SERIAL%"

  oobe_settings = {
    hide_eula                   = true
    hide_privacy_settings       = true
    hide_change_account_options = true
    user_type                   = "standard"
    device_usage_type           = "singleUser"
    skip_keyboard_selection_page = true
    hide_escape_link            = true
  }

  enrollment_status_page = {
    show_progress                           = true
    block_device_use_until_profile_complete = true
    allow_device_use_on_error               = false
    allow_log_collection_on_error           = true
    allow_retry                             = true
    install_progress_timeout_in_minutes     = 60
  }
}

################################################################################
# White Glove Autopilot Profile
################################################################################

module "autopilot_white_glove" {
  source = "../../"

  display_name         = "White Glove Deployment"
  description          = "Pre-provisioning profile for IT deployment"
  device_name_template = "PRE-%SERIAL%"
  enable_white_glove   = true

  oobe_settings = {
    hide_eula             = true
    hide_privacy_settings = true
    user_type             = "standard"
    device_usage_type     = "singleUser"
    hide_escape_link      = true
  }

  enrollment_status_page = {
    show_progress                           = true
    block_device_use_until_profile_complete = true
    allow_log_collection_on_error           = true
    install_progress_timeout_in_minutes     = 120
  }
}

################################################################################
# Kiosk Autopilot Profile
################################################################################

module "autopilot_kiosk" {
  source = "../../"

  display_name         = "Kiosk Self-Deploying"
  description          = "Self-deploying profile for kiosk devices"
  device_name_template = "KIOSK-%SERIAL%"

  oobe_settings = {
    hide_eula                    = true
    hide_privacy_settings        = true
    hide_change_account_options  = true
    device_usage_type            = "shared"
    skip_keyboard_selection_page = true
  }

  enrollment_status_page = {
    show_progress                           = true
    block_device_use_until_profile_complete = true
    install_progress_timeout_in_minutes     = 90
  }
}

################################################################################
# Outputs
################################################################################

output "standard_profile_id" {
  description = "The ID of the standard Autopilot profile."
  value       = module.autopilot_standard.id
}

output "white_glove_profile_id" {
  description = "The ID of the white glove Autopilot profile."
  value       = module.autopilot_white_glove.id
}

output "kiosk_profile_id" {
  description = "The ID of the kiosk Autopilot profile."
  value       = module.autopilot_kiosk.id
}
