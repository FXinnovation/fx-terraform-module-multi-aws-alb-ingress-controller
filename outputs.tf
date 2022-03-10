output "iam_policy_arn" {
  description = "ARN of the IAM policy created."
  value       = element(concat(aws_iam_policy.this.*.arn, []), 0)
}

output "iam_policy_id" {
  description = "ID of the IAM policy created."
  value       = element(concat(aws_iam_policy.this.*.id, []), 0)
}

output "iam_policy_name" {
  description = "Name of the IAM policy created."
  value       = element(concat(aws_iam_policy.this.*.name, []), 0)
}

output "iam_policy_path" {
  description = "Path of the IAM policy created."
  value       = element(concat(aws_iam_policy.this.*.path, []), 0)
}

output "config_map_name" {
  description = "Name of the config map."
  value       = element(concat(kubernetes_config_map.this.*.metadata.0.name, []), 0)
}

output "service_account_name" {
  description = "Name of the service account."
  value       = element(concat(kubernetes_service_account.this.*.metadata.0.name, []), 0)
}

output "cluster_role_name" {
  description = "Name of the cluster role."
  value       = element(concat(kubernetes_cluster_role.this.*.metadata.0.name, []), 0)
}

output "cluster_role_binding_name" {
  description = "Name of the cluster role binding."
  value       = element(concat(kubernetes_cluster_role_binding.this.*.metadata.0.name, []), 0)
}

output "deployment_name" {
  description = "Name of the deployment."
  value       = element(concat(kubernetes_deployment.this.*.metadata.0.name, []), 0)
}

output "namespace" {
  description = "Namespace in which the resources are deployed."
  value       = var.enabled ? var.namespace : ""
}

output "class_name" {
  description = "Name of the ingress class name"
  value       = local.ingress_class_name
}
