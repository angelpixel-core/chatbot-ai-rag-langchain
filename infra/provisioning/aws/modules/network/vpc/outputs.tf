output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID of the VPC created by the module."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "ID of the internet gateway attached to the VPC."
}

output "nat_gateway_id" {
  value       = var.enable_nat ? aws_nat_gateway.this[0].id : null
  description = "ID of the NAT gateway when enabled."
}

output "route_table_ids" {
  value = {
    public       = aws_route_table.public.id
    private_app  = aws_route_table.private_app.id
    private_data = aws_route_table.private_data.id
  }
  description = "IDs of the route tables created by the module."
}

output "public_subnet_ids" {
  value       = [for key in local.public_subnet_keys : aws_subnet.public[key].id]
  description = "IDs of the public subnets."
}

output "private_app_subnet_ids" {
  value       = [for key in local.private_app_subnet_keys : aws_subnet.private_app[key].id]
  description = "IDs of the private application subnets."
}

output "private_data_subnet_ids" {
  value       = [for key in local.private_data_subnet_keys : aws_subnet.private_data[key].id]
  description = "IDs of the private data subnets."
}

output "private_dns_zone_id" {
  value       = local.create_private_dns_zone ? aws_route53_zone.private[0].zone_id : null
  description = "Private Route53 zone ID when DNS is enabled."
}
