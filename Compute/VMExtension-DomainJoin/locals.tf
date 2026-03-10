locals {
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"

  settings = jsonencode({
    Name    = var.domain_name
    OUPath  = var.ou_path
    User    = var.domain_username
    Restart = var.restart
    Options = var.join_options
  })

  protected_settings = jsonencode({
    Password = var.domain_password
  })

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VMExtension-DomainJoin"
  }
  tags = merge(local.default_tags, var.tags)
}
