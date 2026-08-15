data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "../modules/network/vpc"

  name                      = "nonprod"
  region                    = var.region
  cidr_block                = var.vpc_cidr_block
  azs                       = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet_cidrs))
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_app_subnet_cidrs  = var.private_app_subnet_cidrs
  private_data_subnet_cidrs = var.private_data_subnet_cidrs
  enable_nat                = var.enable_nat
  enable_dns                = var.enable_dns
  private_zone_name         = var.private_zone_name
  tags = merge(var.tags, {
    Account     = "nonprod"
    Environment = "qa-staging"
    Purpose     = "application-platform"
  })
}
