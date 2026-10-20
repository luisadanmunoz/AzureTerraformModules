################################################################################
# Local Values
################################################################################

locals {
  # Naming convention: prefix-workload-environment-instance-suffix
  # Example: nsg-web-prod-001
  generated_name = join("-", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance,
    var.name_suffix
  ]))

  # Use explicit name if provided, otherwise use generated name
  nsg_name = var.name != null ? var.name : local.generated_name

  # Merge default tags with user-provided tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "NetworkSecurityGroup"
  }

  tags = merge(local.default_tags, var.tags)

  # Build preset rules
  preset_rules = merge(
    # SSH Rule
    var.allow_ssh.enabled ? {
      "AllowSSH" = {
        priority                                   = var.allow_ssh.priority
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        source_port_ranges                         = null
        destination_port_range                     = "22"
        destination_port_ranges                    = null
        source_address_prefix                      = var.allow_ssh.source_address_prefixes == null ? var.allow_ssh.source_address_prefix : null
        source_address_prefixes                    = var.allow_ssh.source_address_prefixes
        source_application_security_group_ids      = null
        destination_address_prefix                 = "*"
        destination_address_prefixes               = null
        destination_application_security_group_ids = null
        description                                = "Allow SSH inbound"
      }
    } : {},
    # RDP Rule
    var.allow_rdp.enabled ? {
      "AllowRDP" = {
        priority                                   = var.allow_rdp.priority
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        source_port_ranges                         = null
        destination_port_range                     = "3389"
        destination_port_ranges                    = null
        source_address_prefix                      = var.allow_rdp.source_address_prefixes == null ? var.allow_rdp.source_address_prefix : null
        source_address_prefixes                    = var.allow_rdp.source_address_prefixes
        source_application_security_group_ids      = null
        destination_address_prefix                 = "*"
        destination_address_prefixes               = null
        destination_application_security_group_ids = null
        description                                = "Allow RDP inbound"
      }
    } : {},
    # HTTPS Rule
    var.allow_https.enabled ? {
      "AllowHTTPS" = {
        priority                                   = var.allow_https.priority
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        source_port_ranges                         = null
        destination_port_range                     = "443"
        destination_port_ranges                    = null
        source_address_prefix                      = var.allow_https.source_address_prefixes == null ? var.allow_https.source_address_prefix : null
        source_address_prefixes                    = var.allow_https.source_address_prefixes
        source_application_security_group_ids      = null
        destination_address_prefix                 = "*"
        destination_address_prefixes               = null
        destination_application_security_group_ids = null
        description                                = "Allow HTTPS inbound"
      }
    } : {},
    # HTTP Rule
    var.allow_http.enabled ? {
      "AllowHTTP" = {
        priority                                   = var.allow_http.priority
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        source_port_ranges                         = null
        destination_port_range                     = "80"
        destination_port_ranges                    = null
        source_address_prefix                      = var.allow_http.source_address_prefixes == null ? var.allow_http.source_address_prefix : null
        source_address_prefixes                    = var.allow_http.source_address_prefixes
        source_application_security_group_ids      = null
        destination_address_prefix                 = "*"
        destination_address_prefixes               = null
        destination_application_security_group_ids = null
        description                                = "Allow HTTP inbound"
      }
    } : {},
    # Deny All Inbound Rule
    var.deny_all_inbound.enabled ? {
      "DenyAllInbound" = {
        priority                                   = var.deny_all_inbound.priority
        direction                                  = "Inbound"
        access                                     = "Deny"
        protocol                                   = "*"
        source_port_range                          = "*"
        source_port_ranges                         = null
        destination_port_range                     = "*"
        destination_port_ranges                    = null
        source_address_prefix                      = "*"
        source_address_prefixes                    = null
        source_application_security_group_ids      = null
        destination_address_prefix                 = "*"
        destination_address_prefixes               = null
        destination_application_security_group_ids = null
        description                                = "Deny all inbound traffic"
      }
    } : {}
  )

  # Merge preset rules with custom rules
  all_rules = merge(local.preset_rules, var.security_rules)

  # Determine if diagnostic settings should be created
  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null ||
    var.diagnostic_settings.eventhub_authorization_rule_id != null
  )
}
