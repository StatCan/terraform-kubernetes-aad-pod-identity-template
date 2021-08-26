locals {
  pod_identity_template = <<EOF
apiVersion: aadpodidentity.k8s.io/v1
kind: AzureIdentity
metadata:
  name: "${var.identity_name}"
  namespace: "${var.namespace}"
  annotations:
    aadpodidentity.k8s.io/Behavior: namespaced
spec:%{if var.type == 0}
  type: 0
  resourceID: "${var.resource_id}"
  clientID: "${var.client_id}"%{endif}%{if var.type == 1 || var.type == 2}
  type: ${var.type}
  tenantID: "${var.tenant_id}"
  clientID: "${var.client_id}"
  clientPassword: {"name":"${var.secret_name}","namespace":"${var.namespace}"}%{endif}
---
apiVersion: aadpodidentity.k8s.io/v1
kind: AzureIdentityBinding
metadata:
  name: "${var.identity_name}"
  namespace: "${var.namespace}"
spec:
  azureIdentity: "${var.identity_name}"
  selector: "${var.identity_name}"
EOF
}

resource "null_resource" "vault_aad_pod_identity" {
  triggers = {
    namespace     = var.namespace
    identity_name = var.identity_name
    manifests     = local.pod_identity_template
  }

  provisioner "local-exec" {
    command = "cat <<EOF | kubectl apply -f -\n${local.pod_identity_template}\nEOF"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl -n ${self.triggers.namespace} delete AzureIdentityBinding/${self.triggers.identity_name}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl -n ${self.triggers.namespace} delete AzureIdentity/${self.triggers.identity_name}"
  }
}
