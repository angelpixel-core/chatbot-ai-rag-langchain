module "eks_base" {
  source = "../modules/eks/base"

  cluster_name              = "nonprod-eks"
  cluster_version           = "1.31"
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_app_subnet_ids
  node_group_name           = "default"
  node_instance_types       = ["m6i.large"]
  node_desired_size         = 2
  node_min_size             = 2
  node_max_size             = 3
  capacity_type             = "ON_DEMAND"
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  log_retention_in_days     = 30
  tags = merge(var.tags, {
    Account     = "nonprod"
    Environment = "qa-staging"
    Purpose     = "eks-base"
  })
}
