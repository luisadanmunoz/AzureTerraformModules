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
# iOS App Protection Policy
################################################################################

module "ios_app_protection" {
  source = "../../"

  display_name = "iOS Corporate App Protection"
  description  = "Standard app protection policy for corporate iOS apps"
  platform     = "iOS"

  data_protection = {
    encrypt_app_data              = true
    data_backup_blocked           = true
    contact_sync_blocked          = false
    printing_blocked              = true
    save_as_blocked               = true
    third_party_keyboards_blocked = true
    face_id_blocked               = false
  }

  access_requirements = {
    pin_required                    = true
    minimum_pin_length              = 6
    simple_pin_blocked              = true
    touch_id_blocked                = false
    period_offline_before_wipe      = "P30D"
    period_offline_before_access_check = "PT720M"
  }

  conditional_launch = {
    min_os_version           = "15.0"
    jailbroken_device_blocked = true
  }

  apps = [
    {
      app_id    = "com.microsoft.Office.Outlook"
      name      = "Microsoft Outlook"
      publisher = "Microsoft Corporation"
    },
    {
      app_id    = "com.microsoft.Office.Word"
      name      = "Microsoft Word"
      publisher = "Microsoft Corporation"
    },
    {
      app_id    = "com.microsoft.Office.Excel"
      name      = "Microsoft Excel"
      publisher = "Microsoft Corporation"
    },
    {
      app_id    = "com.microsoft.Office.PowerPoint"
      name      = "Microsoft PowerPoint"
      publisher = "Microsoft Corporation"
    }
  ]
}

################################################################################
# Android App Protection Policy
################################################################################

module "android_app_protection" {
  source = "../../"

  display_name = "Android Corporate App Protection"
  description  = "Standard app protection policy for corporate Android apps"
  platform     = "android"

  data_protection = {
    encrypt_app_data       = true
    screen_capture_blocked = true
    data_backup_blocked    = true
    contact_sync_blocked   = false
    printing_blocked       = true
    save_as_blocked        = true
  }

  access_requirements = {
    pin_required                     = true
    minimum_pin_length               = 6
    simple_pin_blocked               = true
    biometric_authentication_blocked = false
    period_offline_before_wipe       = "P30D"
  }

  conditional_launch = {
    min_os_version        = "11"
    rooted_device_blocked = true
  }

  apps = [
    {
      app_id = "com.microsoft.office.outlook"
      name   = "Microsoft Outlook"
    },
    {
      app_id = "com.microsoft.office.word"
      name   = "Microsoft Word"
    },
    {
      app_id = "com.microsoft.office.excel"
      name   = "Microsoft Excel"
    }
  ]
}

################################################################################
# Outputs
################################################################################

output "ios_policy_id" {
  description = "The ID of the iOS app protection policy."
  value       = module.ios_app_protection.id
}

output "android_policy_id" {
  description = "The ID of the Android app protection policy."
  value       = module.android_app_protection.id
}
