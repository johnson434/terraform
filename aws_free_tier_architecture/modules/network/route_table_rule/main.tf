locals {
  gateway_type_igw   = "igw"
  gateway_type_nat   = "nat"
  gateway_type_local = "local"

  gateway_id = var.gateway.name
}

data "aws_route_table" "default" {
  tags = {
    Name = var.route_table_name
  }
}

data "aws_internet_gateway" "default" {
  count = var.gateway.type == local.gateway_type_igw ? 1 : 0
  tags = {
    Name = var.gateway.name
  }
}

data "aws_nat_gateway" "default" {
  count = var.gateway.type == local.gateway_type_nat ? 1 : 0
  tags = {
    Name = var.gateway.name
  }
}

resource "aws_route" "default" {
  route_table_id         = data.aws_route_table.default.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = local.gateway_id
}
