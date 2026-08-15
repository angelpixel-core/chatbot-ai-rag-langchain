check "subnet_counts" {
  assert {
    condition = length(var.public_subnet_cidrs) == length(var.azs) && length(var.private_app_subnet_cidrs) == length(var.azs) && length(var.private_data_subnet_cidrs) == length(var.azs)

    error_message = "Each subnet CIDR list must have the same number of entries as azs."
  }
}

check "dns_name" {
  assert {
    condition     = !var.enable_dns || (var.private_zone_name != null && length(trimspace(var.private_zone_name)) > 0)
    error_message = "private_zone_name must be set when enable_dns is true."
  }
}
