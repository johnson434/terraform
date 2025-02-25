resource "aws_security_group" "default" {
  count       = var.create_sg ? 1 : 0
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.name
  }
}

data "aws_security_group" "default" {
  count = var.create_sg ? 0 : 1
  tags = {
    Name = var.name
  }
}

locals {
  src_dest_type_sg        = "referenced_security_group_name"
  src_dest_type_cidr_ipv4 = "cidr_ipv4"
  src_dest_type_cidr_ipv6 = "cidr_ipv6"
}

resource "aws_vpc_security_group_ingress_rule" "referenced_sg" {
  count                        = var.ingress_rules_referenced_sg != null ? length(var.ingress_rules_referenced_sg) : 0
  security_group_id            = var.create_sg ? one(aws_security_group.default).id : one(data.aws_security_group.default).id
  referenced_security_group_id = var.ingress_rules_referenced_sg[count.index].referenced_sg_id
  ip_protocol                  = var.ingress_rules_referenced_sg[count.index].ip_protocol
  from_port                    = var.ingress_rules_referenced_sg[count.index].from_port
  to_port                      = var.ingress_rules_referenced_sg[count.index].to_port
}

resource "aws_vpc_security_group_ingress_rule" "cidr_ipv4" {
  count             = var.ingress_rules_cidr_ipv4 != null ? length(var.ingress_rules_cidr_ipv4) : 0
  security_group_id = var.create_sg ? one(aws_security_group.default).id : one(data.aws_security_group.default).id
  cidr_ipv4         = var.ingress_rules_cidr_ipv4[count.index].cidr_ipv4
  ip_protocol       = var.ingress_rules_cidr_ipv4[count.index].ip_protocol
  from_port         = var.ingress_rules_cidr_ipv4[count.index].from_port
  to_port           = var.ingress_rules_cidr_ipv4[count.index].to_port
}

resource "aws_vpc_security_group_ingress_rule" "cidr_ipv6" {
  count             = var.ingress_rules_cidr_ipv6 != null ? length(var.ingress_rules_cidr_ipv6) : 0
  security_group_id = var.create_sg ? one(aws_security_group.default).id : one(data.aws_security_group.default).id
  cidr_ipv6         = var.ingress_rules_cidr_ipv6[count.index].cidr_ipv6
  ip_protocol       = var.ingress_rules_cidr_ipv6[count.index].ip_protocol
  from_port         = var.ingress_rules_cidr_ipv6[count.index].from_port
  to_port           = var.ingress_rules_cidr_ipv6[count.index].to_port
}

resource "aws_vpc_security_group_egress_rule" "referenced_sg" {
  count                        = var.egress_rules_referenced_sg != null ? length(var.egress_rules_referenced_sg) : 0
  security_group_id            = var.create_sg ? one(aws_security_group.default).id : one(data.aws_security_group.default).id
  referenced_security_group_id = var.egress_rules_referenced_sg[count.index].referenced_sg_id
  ip_protocol                  = var.egress_rules_referenced_sg[count.index].ip_protocol
  from_port                    = var.egress_rules_referenced_sg[count.index].from_port
  to_port                      = var.egress_rules_referenced_sg[count.index].to_port
}

resource "aws_vpc_security_group_egress_rule" "cidr_ipv4" {
  count             = var.egress_rules_cidr_ipv4 != null ? length(var.egress_rules_cidr_ipv4) : 0
  security_group_id = var.create_sg ? one(aws_security_group.default).id : one(data.aws_security_group.default).id
  cidr_ipv4         = var.egress_rules_cidr_ipv4[count.index].cidr_ipv4
  ip_protocol       = var.egress_rules_cidr_ipv4[count.index].ip_protocol
  from_port         = var.egress_rules_cidr_ipv4[count.index].from_port
  to_port           = var.egress_rules_cidr_ipv4[count.index].to_port
}

resource "aws_vpc_security_group_egress_rule" "cidr_ipv6" {
  count             = var.egress_rules_cidr_ipv6 != null ? length(var.egress_rules_cidr_ipv6) : 0
  security_group_id = var.create_sg ? one(aws_security_group.default).id : one(data.aws_security_group.default).id
  cidr_ipv6         = var.egress_rules_cidr_ipv6[count.index].cidr_ipv6
  ip_protocol       = var.egress_rules_cidr_ipv6[count.index].ip_protocol
  from_port         = var.egress_rules_cidr_ipv6[count.index].from_port
  to_port           = var.egress_rules_cidr_ipv6[count.index].to_port
}
