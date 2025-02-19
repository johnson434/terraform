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

resource "aws_network_acl" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_network_acl_association" "default" {
  network_acl_id = aws_network_acl.default.id
  subnet_id      = data.aws_subnet.default.id
}

resource "aws_network_acl_rule" "default" {
  for_each = var.nacl_rules

  network_acl_id = aws_network_acl.default.id
  rule_number    = each.value.rule_number
  egress         = each.value.egress
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block 
  from_port      = each.value.from_port 
  to_port        = each.value.to_port 
}
