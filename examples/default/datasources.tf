#####
# Datasources
#####

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_region" "current" {}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.name
}
