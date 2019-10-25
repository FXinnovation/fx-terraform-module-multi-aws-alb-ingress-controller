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
  source = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-aws-eks.git?ref=1.0.0"

  iam_role_name       = random_string.this.result
  name                = random_string.this.result
  security_group_name = random_string.this.result
  subnet_ids          = tolist(data.aws_subnet_ids.this.ids)
}

#####
# EKS Worker Pool
#####

module "eks_worker_pool" {
  source = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-aws-eks-worker-pool.git?ref=0.1.0"

  autoscaling_group_name = random_string.this.result

  cluster_certificate       = module.eks.certificate_authority
  cluster_endpoint          = module.eks.endpoint
  cluster_name              = module.eks.name
  cluster_security_group_id = module.eks.security_group_id

  iam_role_name             = random_string.this.result
  iam_instance_profile_name = random_string.this.result

  name_prefix = random_string.this.result

  security_group_name = random_string.this.result

  subnet_ids = tolist(data.aws_subnet_ids.this.ids)
}

#####
# ALB Ingress Controller
#####

module "alb_ingress_controller" {
  source = "../../"

  iam_policy_name      = random_string.this.result
  eks_worker_role_arn  = module.eks_worker_pool.iam_role_arn
  config_map_name      = random_string.this.result
  service_account_name = random_string.this.result
  cluster_role_name    = random_string.this.result
  deployment_name      = random_string.this.result
}
