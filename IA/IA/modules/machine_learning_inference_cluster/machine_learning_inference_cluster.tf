#############################################################################
# MACHINE LEARNING INFERENCE CLUSTER
#############################################################################
resource "azurerm_machine_learning_inference_cluster" "machine_learning_inference_cluster" {
  name                          = var.machine_learning_inference_cluster_name
  machine_learning_workspace_id = var.machine_learning_workspace_id
  location                      = var.location
  kubernetes_cluster_id         = var.kubernetes_cluster_id
  cluster_purpose               = var.cluster_purpose
  description                   = var.description
  tags                          = var.tags

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "ssl" {
    for_each = var.ssl != null ? [var.ssl] : []

    content {
      cert                      = try(ssl.value["cert"], null)
      cname                     = try(ssl.value["cname"], null)
      key                       = try(ssl.value["key"], null)
      leaf_domain_label         = try(ssl.value["leaf_domain_label"], null)
      overwrite_existing_domain = try(ssl.value["overwrite_existing_domain"], null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition = (
        var.ssl == null ||
        (
          (
            try(var.ssl["cert"], null) != null ||
            try(var.ssl["cname"], null) != null ||
            try(var.ssl["key"], null) != null
            ) != (
            try(var.ssl["leaf_domain_label"], null) != null ||
            try(var.ssl["overwrite_existing_domain"], null) != null
          )
        )
      )
      error_message = "ssl must use either cert/cname/key or leaf_domain_label/overwrite_existing_domain, but not both."
    }
  }
}
