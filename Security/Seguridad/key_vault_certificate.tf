#############################################################################
# KEY VAULT CERTIFICATES
#############################################################################
module "key_vault_certificate" {
  source = "./modules/key_vault_certificate"

  for_each = var.key_vault_certificates

  key_vault_certificate_name = each.value["key_vault_certificate_name"]
  key_vault_id = try(
    element([for _, key_vault in module.key_vault : key_vault.id if key_vault.name == each.value["key_vault_name"]], 0),
    each.value["key_vault_id"]
  )
  certificate        = try(each.value["certificate"], null)
  certificate_policy = each.value["certificate_policy"]
  timeouts           = try(each.value["timeouts"], null)
  tags               = try(each.value["tags"], var.tags)
}
