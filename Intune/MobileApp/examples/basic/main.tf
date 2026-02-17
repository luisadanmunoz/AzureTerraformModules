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
# iOS Store App - Microsoft Outlook
################################################################################

module "ios_outlook" {
  source = "../../"

  display_name = "Microsoft Outlook"
  description  = "Microsoft Outlook for iOS"
  publisher    = "Microsoft Corporation"
  app_type     = "iosStoreApp"
  is_featured  = true

  ios_store_app = {
    app_store_url = "https://apps.apple.com/app/microsoft-outlook/id951937596"
    bundle_id     = "com.microsoft.Office.Outlook"
    applicable_device_type = {
      ipad            = true
      iphone_and_ipod = true
    }
    minimum_supported_operating_system = {
      v15_0 = true
    }
  }

  assignments = [
    {
      intent      = "required"
      target_type = "allUsers"
    }
  ]
}

################################################################################
# Android Store App - Microsoft Teams
################################################################################

module "android_teams" {
  source = "../../"

  display_name = "Microsoft Teams"
  description  = "Microsoft Teams for Android"
  publisher    = "Microsoft Corporation"
  app_type     = "androidStoreApp"
  is_featured  = true

  android_store_app = {
    app_store_url = "https://play.google.com/store/apps/details?id=com.microsoft.teams"
    package_id    = "com.microsoft.teams"
    minimum_supported_operating_system = {
      v11_0 = true
    }
  }

  assignments = [
    {
      intent      = "required"
      target_type = "allUsers"
    }
  ]
}

################################################################################
# Web Link App - Company Intranet
################################################################################

module "intranet_link" {
  source = "../../"

  display_name = "Company Intranet"
  description  = "Access the company intranet portal"
  publisher    = "Contoso IT"
  app_type     = "webLink"
  is_featured  = true

  web_link_app = {
    app_url             = "https://intranet.contoso.com"
    use_managed_browser = true
  }

  assignments = [
    {
      intent      = "available"
      target_type = "allUsers"
    }
  ]
}

################################################################################
# Outputs
################################################################################

output "ios_outlook_id" {
  description = "The ID of the iOS Outlook app."
  value       = module.ios_outlook.id
}

output "android_teams_id" {
  description = "The ID of the Android Teams app."
  value       = module.android_teams.id
}

output "intranet_link_id" {
  description = "The ID of the intranet web link."
  value       = module.intranet_link.id
}
