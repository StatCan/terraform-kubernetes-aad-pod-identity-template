# Terraform Kubernetes AAD Pod Identity Templates

## Introduction

This module allows for the deployment and management of AzureIdentity and AzureIdentityBinding objects into a Kubenertes cluster which has Active Directory Pod Identity installed.

## Requirements

This module requires:

* kubectl binary
* a shell environment (cat and pipes)

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* None

## Optional (depending on options configured):

* None

## Usage

```terraform
module "aad_identity_test" {
  source = "git::gitlab.k8s.cloud.statcan.ca/cloudnative/terraform/modules/terraform-kubernetes-aad-pod-identity-template?ref=v1.0.0

  dependencies = [
    "${module.namespace_default.depended_on}",
  ]

  identity_name = "test"
  namespace     = "default"
  resource_id   = "/subscriptions/<subscription_id>/resourceGroups/<resource_group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<named_identity>"
  client_id     = "<client_id>"
}
```

## Variables Values

| Name         | Type   | Required | Value                                               |
| ------------ | ------ | -------- | --------------------------------------------------- |
| dependencies | string | yes      | Dependency name refering to namespace module        |
| namespace    | string | yes      | The namespace Helm will install the chart under     |
| resource_id  | string | yes      | The resource id to be used for the Managed Identity |
| client_id    | string | yes      | The client id to be used for the Managed Identity   |

## History

| Date     | Release | Change                                       |
| -------- | ------- | -------------------------------------------- |
| 20201022 | v1.0.0  | Initial release.                             |
