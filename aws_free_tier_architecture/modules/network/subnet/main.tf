data "aws_vpc" "default" {
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = var.cidr_block
  availability_zone = var.az

  tags = {
    Name = var.name
  }
}
