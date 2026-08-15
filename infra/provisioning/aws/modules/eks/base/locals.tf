locals {
  common_tags = merge(var.tags, {
    Name      = var.cluster_name
    ManagedBy = "Terraform"
  })

  oidc_issuer = replace(aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")
}
