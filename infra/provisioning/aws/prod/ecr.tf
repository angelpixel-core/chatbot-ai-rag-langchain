module "ecr_django" {
  source = "../modules/ecr/repository"

  name = "django"
  tags = merge(var.tags, {
    Account     = "prod"
    Environment = "prod"
    Purpose     = "container-registry"
  })
}
