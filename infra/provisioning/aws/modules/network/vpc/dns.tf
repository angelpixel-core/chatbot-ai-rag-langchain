resource "aws_route53_zone" "private" {
  count = local.create_private_dns_zone ? 1 : 0

  name = var.private_zone_name

  vpc {
    vpc_id = aws_vpc.this.id
  }

  tags = merge(local.common_tags, {
    Name = format("%s-private-zone", var.name)
  })
}
