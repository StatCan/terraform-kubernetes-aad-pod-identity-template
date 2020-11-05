variable "dependencies" {
  type = list(string)
}

variable "identity_name" {
  description = "The name to be given to the Identity."
}

variable "resource_id" {
  description = "The resource ID of the Identity."
  default     = ""
}
variable "client_id" {
  description = "The client ID of the Identity."
}

variable "namespace" {
  description = "The namespace where the resources should be deployed."
}

variable "secret_name" {
  description = "The name of the secret from which to retrieve the certificate or client_secret when type is 1 or 2."
  default     = ""
}

variable "tenant_id" {
  description = "The ID of the Azure Tenant where the Service Principal is located."
  default     = ""
}

variable "type" {
  description = "The type of identity to use. Set type: 0 for user-assigned MSI, type: 1 for Service Principal with client secret, or type: 2 for Service Principal with certificate."

  validation {
    condition     = "${var.type == 0 || var.type == 1 || var.type == 2}"
    error_message = "Type must either be 0, 1, or 2."
  }
}
