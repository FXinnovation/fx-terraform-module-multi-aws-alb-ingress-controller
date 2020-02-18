#####
# Datasources
#####

data "aws_region" "this" {}

#####
# Locals
#####

locals {
  labels = {
    "app.kubernetes.io/name"       = "aws-alb-ingress-controller"
    "app.kubernetes.io/version"    = var.image_version
    "app.kubernetes.io/component"  = "ingress-controller"
    "app.kubernetes.io/part-of"    = "kubernetes"
    "app.kubernetes.io/managed-by" = "terraform"
  }

  ingress_class_name = "alb"
}

#####
# Randoms
#####

resource "random_string" "selector" {
  count = var.enabled ? 1 : 0

  special = false
  upper   = false
  length  = 20
}

#####
# AWS IAM
#####

resource "aws_iam_policy" "this" {
  count = var.enabled ? 1 : 0

  name        = var.iam_policy_name
  path        = var.iam_policy_path
  description = "Allow ALB Ingress-Controller to interact with AWS LB's."

  policy = file("${path.module}/templates/alb-ingress-controller-policy.json")
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.enabled ? 1 : 0

  policy_arn = element(concat(aws_iam_policy.this.*.arn, list("")), 0)
  role       = var.eks_worker_role_name
}

#####
# Kubernetes Config Map
#####

resource "kubernetes_config_map" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.config_map_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.config_map_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.config_map_name
      },
      local.labels,
      var.labels,
      var.config_map_labels
    )
  }

  data = {
    mapRoles = <<EOF
- rolearn: ${var.eks_worker_role_arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
EOF
  }
}

#####
# Kubernetes RBAC
#####

resource "kubernetes_service_account" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.service_account_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.service_account_name
      },
      local.labels,
      var.labels,
      var.service_account_labels
    )
  }
}

resource "kubernetes_cluster_role" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name = var.cluster_role_name
    annotations = merge(
      var.annotations,
      var.cluster_role_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.cluster_role_name
      },
      local.labels,
      var.labels,
      var.cluster_role_labels
    )
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["configmaps", "endpoints", "events", "ingresses", "ingresses/status", "services"]
    verbs      = ["get", "list", "watch", "create", "update", "patch"]
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["nodes", "pods", "secrets", "services", "namespaces"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name = var.cluster_role_binding_name
    annotations = merge(
      var.annotations,
      var.cluster_role_binding_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.cluster_role_binding_name
      },
      local.labels,
      var.labels,
      var.cluster_role_binding_labels
    )
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = element(concat(kubernetes_cluster_role.this.*.metadata.0.name, list("")), 0)
  }

  subject {
    kind      = "ServiceAccount"
    name      = element(concat(kubernetes_service_account.this.*.metadata.0.name, list("")), 0)
    namespace = var.namespace
  }
}

#####
# Kubernetes Deployment
#####

resource "kubernetes_deployment" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.deployment_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.deployment_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.deployment_name
      },
      local.labels,
      var.labels,
      var.deployment_labels
    )
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app    = "aws-alb-ingress-controller"
        random = element(concat(random_string.selector.*.result, list("")), 0)
      }
    }

    strategy {
      rolling_update {
        max_surge       = 1
        max_unavailable = 1
      }
      type = "RollingUpdate"
    }

    template {
      metadata {
        annotations = merge(
          var.annotations,
          var.deployment_annotations
        )
        labels = merge(
          {
            "app.kubernetes.io/instance" = var.deployment_name
            app                          = "aws-alb-ingress-controller"
            random                       = element(concat(random_string.selector.*.result, list("")), 0)
          },
          local.labels,
          var.labels,
          var.deployment_labels
        )
      }

      spec {
        container {
          args              = ["--ingress-class=${local.ingress_class_name}", "--cluster-name=${var.eks_cluster_name}", "--aws-region=${data.aws_region.this.name}"]
          image             = "docker.io/amazon/aws-alb-ingress-controller:${var.image_version}"
          name              = "aws-alb-ingress-controller"
          image_pull_policy = "Always"

          resources {}

        }
        service_account_name            = element(concat(kubernetes_service_account.this.*.metadata.0.name, list("")), 0)
        automount_service_account_token = true
      }
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.this,
    kubernetes_config_map.this,
    kubernetes_cluster_role_binding.this
  ]
}
