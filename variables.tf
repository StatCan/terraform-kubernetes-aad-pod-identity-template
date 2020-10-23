variable "dependencies" {
  type = list(string)
}

variable "identity_name" {
  description = "The name to be given to the Identity."
}

variable "resource_id" {
  description = "The resource ID of the Identity."
}
variable "client_id" {
  description = "The client ID of the Identity."
}

variable "namespace" {
  description = "The namespace where the resources should be deployed."
}