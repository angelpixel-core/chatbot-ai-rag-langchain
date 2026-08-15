resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = local.route_table_names.public
    Tier = "public"
  })
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = local.route_table_names.private_app
    Tier = "private-app"
  })
}

resource "aws_route" "private_app_default" {
  count = var.enable_nat ? 1 : 0

  route_table_id         = aws_route_table.private_app.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id
}

resource "aws_route_table_association" "private_app" {
  for_each = local.private_app_subnets

  subnet_id      = aws_subnet.private_app[each.key].id
  route_table_id = aws_route_table.private_app.id
}

resource "aws_route_table" "private_data" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = local.route_table_names.private_data
    Tier = "private-data"
  })
}

resource "aws_route" "private_data_default" {
  count = var.enable_nat ? 1 : 0

  route_table_id         = aws_route_table.private_data.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id
}

resource "aws_route_table_association" "private_data" {
  for_each = local.private_data_subnets

  subnet_id      = aws_subnet.private_data[each.key].id
  route_table_id = aws_route_table.private_data.id
}
