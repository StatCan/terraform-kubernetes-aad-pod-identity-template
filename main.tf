resource "kubernetes_manifest" "azureidentity_user_assigned" {
  count = var.type == 0 ? 1 : 0

  manifest = {
    "apiVersion" = "aadpodidentity.k8s.io/v1"
    "kind"       = "AzureIdentity"
    "metadata" = {
      "annotations" = {
        "aadpodidentity.k8s.io/Behavior" = "namespaced"
      }
      "name"      = var.identity_name
      "namespace" = var.namespace
    }
    "spec" = {
      "clientID"   = var.client_id
      "resourceID" = var.resource_id
      "type"       = 0
    }
  }
}

resource "kubernetes_manifest" "azureidentity_service_principal" {
  count = var.type > 0 ? 1 : 0

  manifest = {
    "apiVersion" = "aadpodidentity.k8s.io/v1"
    "kind"       = "AzureIdentity"
    "metadata" = {
      "annotations" = {
        "aadpodidentity.k8s.io/Behavior" = "namespaced"
      }
      "name"      = var.identity_name
      "namespace" = var.namespace
    }
    "spec" = {
      "tenantID" = var.tenant_id
      "clientID" = var.resource_id
      "clientPassword" = {
        "name"      = var.secret_name
        "namespace" = var.namespace
      }
    }
  }
}

resource "kubernetes_manifest" "azureidentitybinding" {
  manifest = {
    "apiVersion" = "aadpodidentity.k8s.io/v1"
    "kind"       = "AzureIdentityBinding"
    "metadata" = {
      "name"      = var.identity_name
      "namespace" = var.namespace
    }
    "spec" = {
      "azureIdentity" = var.identity_name
      "selector"      = var.identity_name
    }
  }
}
