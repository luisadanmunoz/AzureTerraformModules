################################################################################
# Entra ID User
################################################################################

resource "azuread_user" "this" {
  count = var.create ? 1 : 0

  display_name        = var.display_name
  user_principal_name = var.user_principal_name

  account_enabled       = var.account_enabled
  password              = var.password
  force_password_change = var.force_password_change

  mail          = var.mail
  mail_nickname = var.mail_nickname
  given_name    = var.given_name
  surname       = var.surname

  job_title       = var.job_title
  department      = var.department
  company_name    = var.company_name
  office_location = var.office_location
  usage_location  = var.usage_location

  mobile_phone    = var.mobile_phone
  business_phones = var.business_phones

  street_address = var.street_address
  city           = var.city
  state          = var.state
  postal_code    = var.postal_code
  country        = var.country

  employee_id   = var.employee_id
  employee_type = var.employee_type
  manager_id    = var.manager_id

  show_in_address_list        = var.show_in_address_list
  disable_password_expiration = var.disable_password_expiration
  disable_strong_password     = var.disable_strong_password
}
