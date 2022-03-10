# terraform-module-multi-aws-alb-ingress-controller

Terraform module that deploy the ALB Ingress Controller on Kubernetes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [kubernetes_cluster_role.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_config_map.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_deployment.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_service_account.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [random_string.selector](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Map of annotations that will be added to all kubernetes resources. | `map` | `{}` | no |
| <a name="input_cluster_role_annotations"></a> [cluster\_role\_annotations](#input\_cluster\_role\_annotations) | Map of annotations that will be added the cluster role. | `map` | `{}` | no |
| <a name="input_cluster_role_binding_annotations"></a> [cluster\_role\_binding\_annotations](#input\_cluster\_role\_binding\_annotations) | Map of annotations that will be added to the cluster role binding. | `map` | `{}` | no |
| <a name="input_cluster_role_binding_labels"></a> [cluster\_role\_binding\_labels](#input\_cluster\_role\_binding\_labels) | Map of labels that will be added to the cluster role binding. | `map` | `{}` | no |
| <a name="input_cluster_role_binding_name"></a> [cluster\_role\_binding\_name](#input\_cluster\_role\_binding\_name) | Name of the cluster role binding that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| <a name="input_cluster_role_labels"></a> [cluster\_role\_labels](#input\_cluster\_role\_labels) | Map of labels that will be added the cluster role. | `map` | `{}` | no |
| <a name="input_cluster_role_name"></a> [cluster\_role\_name](#input\_cluster\_role\_name) | Name of the cluster role that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| <a name="input_config_map_annotations"></a> [config\_map\_annotations](#input\_config\_map\_annotations) | Map of annotations that will be added to the config map. | `map` | `{}` | no |
| <a name="input_config_map_labels"></a> [config\_map\_labels](#input\_config\_map\_labels) | Map of labels that will be added to the config map. | `map` | `{}` | no |
| <a name="input_config_map_name"></a> [config\_map\_name](#input\_config\_map\_name) | Name of the config\_map that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| <a name="input_deployment_annotations"></a> [deployment\_annotations](#input\_deployment\_annotations) | Map of annotations that will be added on the deployment. | `map` | `{}` | no |
| <a name="input_deployment_labels"></a> [deployment\_labels](#input\_deployment\_labels) | Map of labels that will be added on the deployment. | `map` | `{}` | no |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | Name of the deployment that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of the EKS cluster for which this load-balancer is depoyed. | `string` | n/a | yes |
| <a name="input_eks_worker_role_arn"></a> [eks\_worker\_role\_arn](#input\_eks\_worker\_role\_arn) | ARN of the AWS IAM Role given to the EKS workers. (the needed policy will be attached to it.) | `string` | n/a | yes |
| <a name="input_eks_worker_role_name"></a> [eks\_worker\_role\_name](#input\_eks\_worker\_role\_name) | Name of the AWS IAM Role given to the EKS workers. (the needed policy will be attached to it.) | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Wheter or not to enable the module. | `bool` | `true` | no |
| <a name="input_iam_policy_name"></a> [iam\_policy\_name](#input\_iam\_policy\_name) | Name of the policy that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| <a name="input_iam_policy_path"></a> [iam\_policy\_path](#input\_iam\_policy\_path) | Path of the policy that will be created. | `string` | `"/"` | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Version of the image that will be used. | `string` | `"v1.1.3"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Map of labels that will be added to all kubernetes resources. | `map` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace in which the AWS ALB Ingress Controller will be deployed. (It must be created.) | `string` | `"kube-system"` | no |
| <a name="input_service_account_annotations"></a> [service\_account\_annotations](#input\_service\_account\_annotations) | Map of annotations that will be added to the service account. | `map` | `{}` | no |
| <a name="input_service_account_labels"></a> [service\_account\_labels](#input\_service\_account\_labels) | Map of labels that will be added to the service account. | `map` | `{}` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | Name of the service account that will be created. | `string` | `"aws-alb-ingress-controller"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_class_name"></a> [class\_name](#output\_class\_name) | Name of the ingress class name |
| <a name="output_cluster_role_binding_name"></a> [cluster\_role\_binding\_name](#output\_cluster\_role\_binding\_name) | Name of the cluster role binding. |
| <a name="output_cluster_role_name"></a> [cluster\_role\_name](#output\_cluster\_role\_name) | Name of the cluster role. |
| <a name="output_config_map_name"></a> [config\_map\_name](#output\_config\_map\_name) | Name of the config map. |
| <a name="output_deployment_name"></a> [deployment\_name](#output\_deployment\_name) | Name of the deployment. |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | ARN of the IAM policy created. |
| <a name="output_iam_policy_id"></a> [iam\_policy\_id](#output\_iam\_policy\_id) | ID of the IAM policy created. |
| <a name="output_iam_policy_name"></a> [iam\_policy\_name](#output\_iam\_policy\_name) | Name of the IAM policy created. |
| <a name="output_iam_policy_path"></a> [iam\_policy\_path](#output\_iam\_policy\_path) | Path of the IAM policy created. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Namespace in which the resources are deployed. |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | Name of the service account. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
