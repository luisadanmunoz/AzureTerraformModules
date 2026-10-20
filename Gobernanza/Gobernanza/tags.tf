#############################################################################
# TAGS DEFINITIONS
#############################################################################
module "tags" {
  source = "./modules/tags"

  for_each = var.tags_definitions

  workload_name       = each.value["workload_name"]
  environment         = each.value["environment"]
  owner               = each.value["owner"]
  cost_center         = each.value["cost_center"]
  data_classification = try(each.value["data_classification"], "internal")
  criticality         = try(each.value["criticality"], "medium")
  managed_by          = try(each.value["managed_by"], "terraform")
  custom_tags         = try(each.value["custom_tags"], {})
}
