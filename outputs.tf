# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
# and
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-473091030
output "depended_on" {
  value = "${null_resource.dependency_setter.id}-${timestamp()}"
}

output "namespace" {
  value = var.namespace
  description = "The namespace the identity resides."
}

output "identity_name" {
  value = var.identity_name
  description = "The name of the identity."
}