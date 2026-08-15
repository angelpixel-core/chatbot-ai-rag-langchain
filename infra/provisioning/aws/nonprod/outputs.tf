output "environment_layout" {
  value       = local.environment_layout
  description = "Declarative map of the non-production account and environments."
}

output "bootstrap_notes" {
  value       = local.bootstrap_notes
  description = "Notes about what belongs in nonprod."
}

output "network" {
  value       = module.vpc
  description = "Planned non-production network scaffold."
}

output "eks_base" {
  value       = module.eks_base
  description = "Initial non-production EKS base scaffold."
}

output "ecr" {
  value = {
    django = module.ecr_django
  }
  description = "Planned non-production ECR scaffold."
}
