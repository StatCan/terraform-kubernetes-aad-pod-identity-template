# Terraform Kubernetes AAD Pod Identity Templates

## Introduction

This module allows for the deployment and management of AzureIdentity and AzureIdentityBinding objects into a Kubenertes cluster which has Active Directory Pod Identity installed.

## Requirements

This module requires:

* AAD Pod Identity >= 1.6

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* None

## Optional (depending on options configured):

* None

## Usage
Add the following code block to the desired Terraform namespace definition:
```terraform
module "aad_identity_test" {
  source = "git::https://github.com/StatCan/terraform-kubernetes-aad-pod-identity-template.git?ref=v3.0.0"

  type = 0
  identity_name = "test"
  namespace     = "default"
  resource_id   = "/subscriptions/<subscription_id>/resourceGroups/<resource_group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<named_identity>"
  client_id     = "<client_id>"
}
```
The **Client ID** and **Resource ID** are to be provided by the client for their managed identities.

## Variables Values

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | > 2.5 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The client ID of the Identity. | `string` | n/a | yes |
| <a name="input_identity_name"></a> [identity\_name](#input\_identity\_name) | The name to be given to the Identity. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace where the resources should be deployed. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | The type of identity to use. Set type: 0 for user-assigned MSI, type: 1 for Service Principal with client secret, or type: 2 for Service Principal with certificate. | `number` | n/a | yes |
| <a name="input_resource_id"></a> [resource\_id](#input\_resource\_id) | The resource ID of the Identity. | `string` | `""` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | The name of the secret from which to retrieve the certificate or client\_secret when type is 1 or 2. | `string` | `""` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The ID of the Azure Tenant where the Service Principal is located. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_identity_name"></a> [identity\_name](#output\_identity\_name) | The name of the identity. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace the identity resides. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Migrating to v3.0.0

To migrate to the v3.0.0 module without destroying and recreating the resources, run the following command with the required substitutions:

```bash
terraform state rm $moduleLabel.null_resource.vault_aad_pod_identity

# for var.type == 0
terraform import $moduleLabel.kubernetes_manifest.azureidentity_user_assigned[0] "apiVersion=aadpodidentity.k8s.io/v1,kind=AzureIdentity,namespace=$namespace,name=$identity_name"

# for var.type > 0
terraform import $moduleLabel.kubernetes_manifest.azureidentity_service_principal[0] "apiVersion=aadpodidentity.k8s.io/v1,kind=AzureIdentity,namespace=$namespace,name=$identity_name"

terraform import $moduleLabel.kubernetes_manifest.azureidentitybinding "apiVersion=aadpodidentity.k8s.io/v1,kind=AzureIdentityBinding,namespace=$namespace,name=$identity_name"
```

## History

| Date     | Release | Change                                          |
| -------- | ------- | ----------------------------------------------- |
| 20201022 | v1.0.0  | Initial release.                                |
| 20201022 | v1.1.0  | Add outputs for namespace and identity_name.    |
| 20210824 | v2.0.0  | Update module to align with Terraform v0.13     |
| 20220427 | v3.0.0  | Migrate to use *kubernetes_manifest* resources. |
| 20230405 | v3.0.1  | Add validation to `identity_name` input variable to ensure compliance with DNS label spec (RFC-1123)|
