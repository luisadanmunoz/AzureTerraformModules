################################################################################
# Azure Key Vault Certificate
################################################################################

resource "azurerm_key_vault_certificate" "this" {
  count = var.create ? 1 : 0

  name         = var.name
  key_vault_id = var.key_vault_id

  dynamic "certificate" {
    for_each = var.certificate != null ? [var.certificate] : []
    content {
      contents = certificate.value.contents
      password = certificate.value.password
    }
  }

  dynamic "certificate_policy" {
    for_each = var.certificate_policy != null ? [var.certificate_policy] : []
    content {
      issuer_parameters {
        name = certificate_policy.value.issuer_parameters.name
      }

      key_properties {
        exportable = certificate_policy.value.key_properties.exportable
        key_type   = certificate_policy.value.key_properties.key_type
        key_size   = certificate_policy.value.key_properties.key_size
        reuse_key  = certificate_policy.value.key_properties.reuse_key
      }

      secret_properties {
        content_type = certificate_policy.value.secret_properties.content_type
      }

      dynamic "lifetime_action" {
        for_each = certificate_policy.value.lifetime_action != null ? certificate_policy.value.lifetime_action : []
        content {
          action {
            action_type = lifetime_action.value.action.action_type
          }

          trigger {
            days_before_expiry  = lifetime_action.value.trigger.days_before_expiry
            lifetime_percentage = lifetime_action.value.trigger.lifetime_percentage
          }
        }
      }

      x509_certificate_properties {
        subject            = certificate_policy.value.x509_certificate_properties.subject
        validity_in_months = certificate_policy.value.x509_certificate_properties.validity_in_months
        key_usage          = certificate_policy.value.x509_certificate_properties.key_usage
        extended_key_usage = certificate_policy.value.x509_certificate_properties.extended_key_usage

        dynamic "subject_alternative_names" {
          for_each = certificate_policy.value.x509_certificate_properties.subject_alternative_names != null ? [certificate_policy.value.x509_certificate_properties.subject_alternative_names] : []
          content {
            dns_names = subject_alternative_names.value.dns_names
            emails    = subject_alternative_names.value.emails
            upns      = subject_alternative_names.value.upns
          }
        }
      }
    }
  }

  tags = local.tags
}
