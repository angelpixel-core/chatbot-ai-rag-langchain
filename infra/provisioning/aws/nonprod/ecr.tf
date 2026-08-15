module "ecr_django" {
  source = "../modules/ecr/repository"

  name = "django"
  tags = merge(var.tags, {
    Account     = "nonprod"
    Environment = "qa-staging"
    Purpose     = "container-registry"
  })
}
