#############################################################################
# KEY VAULT CERTIFICATE
#############################################################################
resource "azurerm_key_vault_certificate" "key_vault_certificate" {
  name         = var.key_vault_certificate_name
  key_vault_id = var.key_vault_id
  tags         = var.tags

  dynamic "certificate" {
    for_each = var.certificate != null ? [var.certificate] : []

    content {
      contents = certificate.value["contents"]
      password = try(certificate.value["password"], null)
    }
  }

  certificate_policy {
    issuer_parameters {
      name = var.certificate_policy.issuer_parameters.name
    }

    key_properties {
      exportable = var.certificate_policy.key_properties.exportable
      key_type   = var.certificate_policy.key_properties.key_type
      reuse_key  = var.certificate_policy.key_properties.reuse_key
      curve      = try(var.certificate_policy.key_properties.curve, null)
      key_size   = try(var.certificate_policy.key_properties.key_size, null)
    }

    dynamic "lifetime_action" {
      for_each = try(var.certificate_policy.lifetime_actions, [])

      content {
        action {
          action_type = lifetime_action.value.action.action_type
        }

        trigger {
          days_before_expiry  = try(lifetime_action.value.trigger.days_before_expiry, null)
          lifetime_percentage = try(lifetime_action.value.trigger.lifetime_percentage, null)
        }
      }
    }

    secret_properties {
      content_type = var.certificate_policy.secret_properties.content_type
    }

    x509_certificate_properties {
      subject            = var.certificate_policy.x509_certificate_properties.subject
      validity_in_months = var.certificate_policy.x509_certificate_properties.validity_in_months
      key_usage          = var.certificate_policy.x509_certificate_properties.key_usage
      extended_key_usage = try(var.certificate_policy.x509_certificate_properties.extended_key_usage, null)

      dynamic "subject_alternative_names" {
        for_each = try(var.certificate_policy.x509_certificate_properties.subject_alternative_names, null) != null ? [var.certificate_policy.x509_certificate_properties.subject_alternative_names] : []

        content {
          dns_names = try(subject_alternative_names.value["dns_names"], null)
          emails    = try(subject_alternative_names.value["emails"], null)
          upns      = try(subject_alternative_names.value["upns"], null)
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
