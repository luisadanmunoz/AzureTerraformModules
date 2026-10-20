locals {
  # ──────────────────────────────────────────────────────────────────────────────
  # Module identification
  # ──────────────────────────────────────────────────────────────────────────────
  module_name = "AutomationModule"

  # ──────────────────────────────────────────────────────────────────────────────
  # PowerShell Gallery URL template
  # ──────────────────────────────────────────────────────────────────────────────
  ps_gallery_url = "https://www.powershellgallery.com/api/v2/package"

  # Convert PowerShell Gallery modules to standard module format
  gallery_modules = {
    for name, mod in var.powershell_gallery_modules :
    name => {
      uri     = "${local.ps_gallery_url}/${name}/${mod.version}"
      version = mod.version
      hash    = null
    }
  }

  # Merge all modules
  all_modules = merge(var.modules, local.gallery_modules)
}
