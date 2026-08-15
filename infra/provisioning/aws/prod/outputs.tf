output "environment_layout" {
  value       = local.environment_layout
  description = "Declarative map of the production account and environments."
}

output "bootstrap_notes" {
  value       = local.bootstrap_notes
  description = "Notes about what belongs in prod."
}

output "network" {
  value       = module.vpc
  description = "Planned production network scaffold."
}

output "ecr" {
  value = {
    django = module.ecr_django
    nextjs = module.ecr_nextjs
  }
  description = "Planned production ECR scaffold."
}
