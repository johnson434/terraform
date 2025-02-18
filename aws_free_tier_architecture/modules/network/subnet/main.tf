data "aws_vpc" "default" {
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.default.id 
  cidr_block = var.cidr_block 

  tags = {
    Name = var.name 
  }
}
