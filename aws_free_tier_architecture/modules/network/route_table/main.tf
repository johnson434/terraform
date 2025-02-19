data "aws_vpc" "default" {
  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnet" "default" {
  tags = {
    Name = var.subnet_name
  }
}

resource "aws_route_table" "default" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "default" {
  subnet_id      = data.aws_subnet.default.id
  route_table_id = aws_route_table.default.id
}
