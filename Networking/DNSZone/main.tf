################################################################################
# Public DNS Zone
################################################################################

resource "azurerm_dns_zone" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name

  dynamic "soa_record" {
    for_each = var.soa_record != null ? [var.soa_record] : []
    content {
      email        = soa_record.value.email
      expire_time  = soa_record.value.expire_time
      minimum_ttl  = soa_record.value.minimum_ttl
      refresh_time = soa_record.value.refresh_time
      retry_time   = soa_record.value.retry_time
      ttl          = soa_record.value.ttl
    }
  }

  tags = local.tags
}

################################################################################
# A Records
################################################################################

resource "azurerm_dns_a_record" "this" {
  for_each = var.create ? var.a_records : {}

  name                = each.key
  zone_name           = azurerm_dns_zone.this[0].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records

  tags = local.tags
}

################################################################################
# AAAA Records
################################################################################

resource "azurerm_dns_aaaa_record" "this" {
  for_each = var.create ? var.aaaa_records : {}

  name                = each.key
  zone_name           = azurerm_dns_zone.this[0].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records

  tags = local.tags
}

################################################################################
# CAA Records
################################################################################

resource "azurerm_dns_caa_record" "this" {
  for_each = var.create ? var.caa_records : {}

  name                = each.key
  zone_name           = azurerm_dns_zone.this[0].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.records
    content {
      flags = record.value.flags
      tag   = record.value.tag
      value = record.value.value
    }
  }

  tags = local.tags
}

################################################################################
# CNAME Records
################################################################################

resource "azurerm_dns_cname_record" "this" {
  for_each = var.create ? var.cname_records : {}

  name                = each.key
  zone_name           = azurerm_dns_zone.this[0].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.record

  tags = local.tags
}

################################################################################
# MX Records
################################################################################

resource "azurerm_dns_mx_record" "this" {
  for_each = var.create ? var.mx_records : {}

  name                = each.key
  zone_name           = azurerm_dns_zone.this[0].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.records
    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }

  tags = local.tags
}

################################################################################
# NS Records
################################################################################

resource "azurerm_dns_ns_record" "this" {
  for_each = var.create ? var.ns_records : {}

  name                = each.key
  zone_name           = azurerm_dns_zone.this[0].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records

  tags = local.tags
}

################################################################################
# PTR Records
################################################################################

resource "azurerm_dns_ptr_record" "this" {
  for_each = var.create ? var.ptr_records : {}

  name                = each.key
  zone_name           = azurerm_dns_zone.this[0].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records

  tags = local.tags
}

################################################################################
# SRV Records
################################################################################

resource "azurerm_dns_srv_record" "this" {
  for_each = var.create ? var.srv_records : {}

  name                = each.key
  zone_name           = azurerm_dns_zone.this[0].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.records
    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }

  tags = local.tags
}

################################################################################
# TXT Records
################################################################################

resource "azurerm_dns_txt_record" "this" {
  for_each = var.create ? var.txt_records : {}

  name                = each.key
  zone_name           = azurerm_dns_zone.this[0].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }

  tags = local.tags
}
