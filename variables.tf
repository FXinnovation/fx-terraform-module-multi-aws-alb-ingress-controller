variable "enabled" {
  description = "Wheter or not to enable the module."
  default     = true
}

variable "iam_policy_name" {
  description = "Name of the policy that will be created."
  default     = "aws-alb-ingress-controller"
}

variable "iam_policy_path" {
  description = "Path of the policy that will be created."
  default     = "/"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster for which this load-balancer is depoyed."
  type        = string
}

variable "eks_worker_role_name" {
  description = "Name of the AWS IAM Role given to the EKS workers. (the needed policy will be attached to it.)"
  type        = string
}

variable "config_map_name" {
  description = "Name of the config_map that will be created."
  default     = "aws-alb-ingress-controller"
}

variable "namespace" {
  description = "Namespace in which the AWS ALB Ingress Controller will be deployed. (It must be created.)"
  default     = "kube-system"
}

variable "annotations" {
  description = "Map of annotations that will be added to all kubernetes resources."
  default     = {}
}

variable "config_map_annotations" {
  description = "Map of annotations that will be added to the config map."
  default     = {}
}

variable "labels" {
  description = "Map of labels that will be added to all kubernetes resources."
  default     = {}
}

variable "config_map_labels" {
  description = "Map of labels that will be added to the config map."
  default     = {}
}

variable "service_account_name" {
  description = "Name of the service account that will be created."
  default     = "aws-alb-ingress-controller"
}

variable "service_account_annotations" {
  description = "Map of annotations that will be added to the service account."
  default     = {}
}

variable "service_account_labels" {
  description = "Map of labels that will be added to the service account."
  default     = {}
}

variable "cluster_role_name" {
  description = "Name of the cluster role that will be created."
  default     = "aws-alb-ingress-controller"
}

variable "cluster_role_annotations" {
  description = "Map of annotations that will be added the cluster role."
  default     = {}
}

variable "cluster_role_labels" {
  description = "Map of labels that will be added the cluster role."
  default     = {}
}

variable "cluster_role_binding_name" {
  description = "Name of the cluster role binding that will be created."
  default     = "aws-alb-ingress-controller"
}

variable "cluster_role_binding_annotations" {
  description = "Map of annotations that will be added to the cluster role binding."
  default     = {}
}

variable "cluster_role_binding_labels" {
  description = "Map of labels that will be added to the cluster role binding."
  default     = {}
}

variable "deployment_name" {
  description = "Name of the deployment that will be created."
  default     = "aws-alb-ingress-controller"
}

variable "deployment_annotations" {
  description = "Map of annotations that will be added on the deployment."
  default     = {}
}

variable "deployment_labels" {
  description = "Map of labels that will be added on the deployment."
  default     = {}
}

variable "image_version" {
  description = "Version of the image that will be used."
  default     = "v1.1.3"
}
