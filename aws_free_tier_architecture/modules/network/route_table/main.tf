resource "aws_route_table" "default" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "default" {
  for_each = toset(var.associated_subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.default.id
}

resource "aws_route" "default" {
  count = length(var.aws_routes)
  route_table_id         = aws_route_table.default.id
  destination_cidr_block = var.aws_routes[count.index].destination_cidr_block
  gateway_id             = var.aws_routes[count.index].gateway_id
}
