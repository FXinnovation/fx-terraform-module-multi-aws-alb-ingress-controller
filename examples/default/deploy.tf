#####
# Randoms
#####

resource "random_string" "this" {
  length  = 8
  special = false
  upper   = false
  number  = false
}

#####
# EKS Cluster
#####

module "eks" {
  source = "github.com/FXinnovation/fx-terraform-module-aws-eks.git?ref=1.1.1"

  iam_role_name       = "eks${random_string.this.result}"
  name                = "eks${random_string.this.result}"
  security_group_name = "eks${random_string.this.result}"
  subnet_ids          = tolist(data.aws_subnet_ids.this.ids)
  kubernetes_version  = "1.13"
  private_access      = false

  allowed_security_group_ids = [module.eks_worker_pool.security_group_id]
}

#####
# EKS Worker Pool
#####

module "eks_worker_pool" {
  source = "github.com/FXinnovation/fx-terraform-module-aws-eks-worker-pool.git?ref=1.0.0"

  autoscaling_group_name = random_string.this.result

  cluster_name              = module.eks.name
  cluster_security_group_id = module.eks.security_group_id

  kubernetes_version = module.eks.kubernetes_version

  iam_role_name             = "ekswp${random_string.this.result}"
  iam_instance_profile_name = "ekswp${random_string.this.result}"

  name_prefix = "ekswp${random_string.this.result}"

  security_group_name = "ekswp${random_string.this.result}"

  subnet_ids = tolist(data.aws_subnet_ids.this.ids)
}

#####
# ALB Ingress Controller
#####

module "alb_ingress_controller" {
  source = "../../"

  iam_policy_name      = random_string.this.result
  eks_worker_role_name = module.eks_worker_pool.iam_role_name
  eks_worker_role_arn  = module.eks_worker_pool.iam_role_arn
  eks_cluster_name     = module.eks.name
  config_map_name      = random_string.this.result
  service_account_name = random_string.this.result
  cluster_role_name    = random_string.this.result
  deployment_name      = random_string.this.result
}
