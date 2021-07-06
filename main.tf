resource "helm_release" "identity" {
  chart     = "${path.module}/azure-identity"
  name      = "identity-${var.identity_name}"
  namespace = var.namespace

  set {
    name  = "identity_name"
    value = var.identity_name
  }

  set {
    name  = "type"
    value = var.type
  }

  set {
    name  = "resource_id"
    value = var.resource_id
  }

  set {
    name  = "client_id"
    value = var.client_id
  }

  set {
    name  = "secret_name"
    value = var.secret_name
  }
}
