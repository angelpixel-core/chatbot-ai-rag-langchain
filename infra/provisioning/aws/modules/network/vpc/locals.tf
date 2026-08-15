locals {
  common_tags = merge(var.tags, {
    Name      = var.name
    ManagedBy = "Terraform"
  })

  public_subnets = {
    for idx, cidr in var.public_subnet_cidrs : format("%s-public-%02d", var.name, idx + 1) => {
      az   = var.azs[idx]
      cidr = cidr
      tier = "public"
    }
  }

  private_app_subnets = {
    for idx, cidr in var.private_app_subnet_cidrs : format("%s-private-app-%02d", var.name, idx + 1) => {
      az   = var.azs[idx]
      cidr = cidr
      tier = "private-app"
    }
  }

  private_data_subnets = {
    for idx, cidr in var.private_data_subnet_cidrs : format("%s-private-data-%02d", var.name, idx + 1) => {
      az   = var.azs[idx]
      cidr = cidr
      tier = "private-data"
    }
  }

  public_subnet_keys       = sort(keys(local.public_subnets))
  private_app_subnet_keys  = sort(keys(local.private_app_subnets))
  private_data_subnet_keys = sort(keys(local.private_data_subnets))
  create_private_dns_zone  = var.enable_dns && var.private_zone_name != null
  route_table_names = {
    public       = format("%s-public", var.name)
    private_app  = format("%s-private-app", var.name)
    private_data = format("%s-private-data", var.name)
  }
}
