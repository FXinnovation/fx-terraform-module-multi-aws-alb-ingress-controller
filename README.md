# terraform-module-multi-aws-alb-ingress-controller

Terraform module that deploy the ALB Ingress Controller on Kubernetes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| kubernetes | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| annotations | Map of annotations that will be added to all kubernetes resources. | `map` | `{}` | no |
| cluster\_role\_annotations | Map of annotations that will be added the cluster role. | `map` | `{}` | no |
| cluster\_role\_binding\_annotations | Map of annotations that will be added to the cluster role binding. | `map` | `{}` | no |
| cluster\_role\_binding\_labels | Map of labels that will be added to the cluster role binding. | `map` | `{}` | no |
| cluster\_role\_binding\_name | Name of the cluster role binding that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| cluster\_role\_labels | Map of labels that will be added the cluster role. | `map` | `{}` | no |
| cluster\_role\_name | Name of the cluster role that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| config\_map\_annotations | Map of annotations that will be added to the config map. | `map` | `{}` | no |
| config\_map\_labels | Map of labels that will be added to the config map. | `map` | `{}` | no |
| config\_map\_name | Name of the config\_map that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| deployment\_annotations | Map of annotations that will be added on the deployment. | `map` | `{}` | no |
| deployment\_labels | Map of labels that will be added on the deployment. | `map` | `{}` | no |
| deployment\_name | Name of the deployment that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| eks\_cluster\_name | Name of the EKS cluster for which this load-balancer is depoyed. | `string` | n/a | yes |
| eks\_worker\_role\_arn | ARN of the AWS IAM Role given to the EKS workers. (the needed policy will be attached to it.) | `string` | n/a | yes |
| eks\_worker\_role\_name | Name of the AWS IAM Role given to the EKS workers. (the needed policy will be attached to it.) | `string` | n/a | yes |
| enabled | Wheter or not to enable the module. | `bool` | `true` | no |
| iam\_policy\_name | Name of the policy that will be created. | `string` | `"aws-alb-ingress-controller"` | no |
| iam\_policy\_path | Path of the policy that will be created. | `string` | `"/"` | no |
| image\_version | Version of the image that will be used. | `string` | `"v1.1.3"` | no |
| labels | Map of labels that will be added to all kubernetes resources. | `map` | `{}` | no |
| namespace | Namespace in which the AWS ALB Ingress Controller will be deployed. (It must be created.) | `string` | `"kube-system"` | no |
| service\_account\_annotations | Map of annotations that will be added to the service account. | `map` | `{}` | no |
| service\_account\_labels | Map of labels that will be added to the service account. | `map` | `{}` | no |
| service\_account\_name | Name of the service account that will be created. | `string` | `"aws-alb-ingress-controller"` | no |

## Outputs

| Name | Description |
|------|-------------|
| class\_name | Name of the ingress class name |
| cluster\_role\_binding\_name | Name of the cluster role binding. |
| cluster\_role\_name | Name of the cluster role. |
| config\_map\_name | Name of the config map. |
| deployment\_name | Name of the deployment. |
| iam\_policy\_arn | ARN of the IAM policy created. |
| iam\_policy\_id | ID of the IAM policy created. |
| iam\_policy\_name | Name of the IAM policy created. |
| iam\_policy\_path | Path of the IAM policy created. |
| namespace | Namespace in which the resources are deployed. |
| service\_account\_name | Name of the service account. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
