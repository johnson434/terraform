locals {
  sg_id                   = data.aws_security_group.associated.id
  referenced_sg_id        = length(data.aws_security_group.referenced_security_group[*]) == 1 ? data.aws_security_group.referenced_security_group[0].id : null
  src_dest_type_sg        = "referenced_security_group_name"
  src_dest_type_cidr_ipv4 = "cidr_ipv4"
  src_dest_type_cidr_ipv6 = "cidr_ipv6"
}

data "aws_security_group" "associated" {
  name = var.security_group_name
}

data "aws_security_group" "referenced_security_group" {
  count = var.src_dest.type == local.src_dest_type_sg ? 1 : 0
  name  = var.src_dest.referenced_security_group_name
}

resource "aws_vpc_security_group_ingress_rule" "default" {
  count                        = var.is_ingress_rule == true ? 1 : 0
  security_group_id            = local.sg_id
  referenced_security_group_id = var.src_dest.type == local.src_dest_type_sg ? local.referenced_sg_id : null
  cidr_ipv4                    = var.src_dest.type == local.src_dest_type_cidr_ipv4 ? var.src_dest.cidr_ipv4 : null
  cidr_ipv6                    = var.src_dest.type == local.src_dest_type_cidr_ipv6 ? var.src_dest.cidr_ipv6 : null
  ip_protocol                  = var.ip_protocol
  from_port                    = var.from_port
  to_port                      = var.to_port
}

resource "aws_vpc_security_group_egress_rule" "default" {
  count             = var.is_ingress_rule == true ? 0 : 1
  security_group_id = local.sg_id
  # 안되면 dynamic
  referenced_security_group_id = var.src_dest.type == local.src_dest_type_sg ? local.referenced_sg_id : null
  cidr_ipv4                    = var.src_dest.type == local.src_dest_type_cidr_ipv4 ? var.src_dest.cidr_ipv4 : null
  cidr_ipv6                    = var.src_dest.type == local.src_dest_type_cidr_ipv6 ? var.src_dest.cidr_ipv6 : null
  ip_protocol                  = var.ip_protocol
  from_port                    = var.from_port
  to_port                      = var.to_port
}
