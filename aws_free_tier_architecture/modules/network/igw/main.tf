data "aws_vpc" "default" {
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = var.name
  }
}
