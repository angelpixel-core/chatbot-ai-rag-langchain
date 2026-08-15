resource "aws_eip" "nat" {
  count  = var.enable_nat ? 1 : 0
  domain = "vpc"

  tags = merge(local.common_tags, {
    Name = format("%s-nat-eip", var.name)
  })
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[local.public_subnet_keys[0]].id

  tags = merge(local.common_tags, {
    Name = format("%s-nat", var.name)
  })

  depends_on = [aws_internet_gateway.this]
}
