variable "identity_name" {
  type        = string
  description = "The name to be given to the Identity."

  validation {
    # DNS Label Spec: https://tools.ietf.org/html/rfc1123
    condition     = can(regex("^[a-zA-Z]{1}([a-zA-Z0-9-]){0,62}$", var.identity_name))
    error_message = "the provided identity name is not a valid DNS subdomain specified in RFC-1123. Must match the following regular expression '^[a-zA-Z]{1}([a-zA-Z0-9-]){0,62}$'"
  }
}

variable "resource_id" {
  type        = string
  description = "The resource ID of the Identity."
  default     = ""
}

variable "client_id" {
  type        = string
  description = "The client ID of the Identity."
}

variable "namespace" {
  type        = string
  description = "The namespace where the resources should be deployed."
}

variable "secret_name" {
  type        = string
  description = "The name of the secret from which to retrieve the certificate or client_secret when type is 1 or 2."
  default     = ""
}

variable "tenant_id" {
  type        = string
  description = "The ID of the Azure Tenant where the Service Principal is located."
  default     = ""
}

variable "type" {
  type        = number
  description = "The type of identity to use. Set type: 0 for user-assigned MSI, type: 1 for Service Principal with client secret, or type: 2 for Service Principal with certificate."

  validation {
    condition     = var.type == 0 || var.type == 1 || var.type == 2
    error_message = "Type must either be 0, 1, or 2."
  }
}
