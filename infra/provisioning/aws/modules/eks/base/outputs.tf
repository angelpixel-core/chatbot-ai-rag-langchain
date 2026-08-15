output "cluster_name" {
  value       = aws_eks_cluster.this.name
  description = "Name of the EKS cluster."
}

output "cluster_arn" {
  value       = aws_eks_cluster.this.arn
  description = "ARN of the EKS cluster."
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "Cluster API endpoint."
}

output "cluster_security_group_id" {
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  description = "Security group ID created for the cluster."
}

output "cluster_oidc_issuer" {
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
  description = "OIDC issuer URL for the cluster."
}

output "oidc_provider_arn" {
  value       = aws_iam_openid_connect_provider.this.arn
  description = "OIDC provider ARN used for IRSA."
}

output "node_group_arn" {
  value       = aws_eks_node_group.this.arn
  description = "ARN of the initial managed node group."
}

output "cluster_log_group_name" {
  value       = aws_cloudwatch_log_group.this.name
  description = "CloudWatch log group used for EKS control plane logs."
}

output "cluster_role_arn" {
  value       = aws_iam_role.cluster.arn
  description = "IAM role used by the EKS control plane."
}

output "node_role_arn" {
  value       = aws_iam_role.node.arn
  description = "IAM role used by the managed node group."
}
