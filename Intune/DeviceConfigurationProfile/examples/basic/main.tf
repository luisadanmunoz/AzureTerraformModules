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
# Windows 10 Device Restrictions Profile
################################################################################

module "windows_restrictions" {
  source = "../../"

  display_name = "Windows 10 Corporate Restrictions"
  description  = "Standard device restrictions for corporate Windows 10 devices"
  platform     = "windows10"
  profile_type = "deviceRestrictions"

  windows_device_restrictions = {
    # Security settings
    password_required       = true
    password_minimum_length = 8
    password_required_type  = "alphanumeric"

    # Browser settings
    edge_require_smart_screen          = true
    edge_block_inprivate_browsing      = true
    smart_screen_block_prompt_override = true

    # Device restrictions
    camera_blocked      = false
    cortana_blocked     = true
    usb_blocked         = false
    screen_capture_blocked = false

    # Store settings
    windows_store_blocked                 = true
    windows_store_enable_private_store_only = true

    # Management
    device_management_block_manual_unenroll = true
  }
}

################################################################################
# Windows 10 Custom OMA-URI Profile
################################################################################

module "windows_custom" {
  source = "../../"

  display_name = "Windows 10 Custom Settings"
  description  = "Custom OMA-URI settings for Windows 10"
  platform     = "windows10"
  profile_type = "custom"

  windows_custom_settings = [
    {
      name        = "Disable Consumer Features"
      description = "Disables Windows consumer features"
      oma_uri     = "./Device/Vendor/MSFT/Policy/Config/Experience/AllowWindowsConsumerFeatures"
      data_type   = "Integer"
      value       = "0"
    },
    {
      name        = "Configure Telemetry Level"
      description = "Sets telemetry to basic"
      oma_uri     = "./Device/Vendor/MSFT/Policy/Config/System/AllowTelemetry"
      data_type   = "Integer"
      value       = "1"
    }
  ]
}

################################################################################
# iOS Device Restrictions Profile
################################################################################

module "ios_restrictions" {
  source = "../../"

  display_name = "iOS Corporate Restrictions"
  description  = "Standard device restrictions for corporate iOS devices"
  platform     = "iOS"
  profile_type = "deviceRestrictions"

  ios_device_restrictions = {
    # App Store
    app_store_require_password = true

    # Safari
    safari_block_autofill = true
    safari_block_popups   = true

    # iCloud
    icloud_require_encrypted_backup = true

    # AirDrop
    air_drop_blocked = true

    # Passcode
    passcode_required       = true
    passcode_minimum_length = 6
    passcode_block_simple   = true
  }
}

################################################################################
# Outputs
################################################################################

output "windows_restrictions_id" {
  description = "The ID of the Windows restrictions profile."
  value       = module.windows_restrictions.id
}

output "windows_custom_id" {
  description = "The ID of the Windows custom profile."
  value       = module.windows_custom.id
}

output "ios_restrictions_id" {
  description = "The ID of the iOS restrictions profile."
  value       = module.ios_restrictions.id
}
