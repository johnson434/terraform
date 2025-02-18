data "aws_security_group" "security_group" {
  name = var.security_group_name
}

data "aws_security_group" "referenced_security_group" {
  count = var.referenced_security_group_name == null ? 0 : 1
  name  = var.referenced_security_group_name
}

locals {
  sg_id            = data.aws_security_group.security_group.id
  referenced_sg_id = length(data.aws_security_group.referenced_security_group[*]) == 1 ? data.aws_security_group.referenced_security_group[0].id : null
}

output "referenced_id" {
  value = local.referenced_sg_id
}

resource "aws_vpc_security_group_ingress_rule" "default" {
  count                        = var.is_ingress_rule == true ? 1 : 0
  security_group_id            = local.sg_id
  referenced_security_group_id = local.referenced_sg_id != null ? local.referenced_sg_id : null
  cidr_ipv4                    = local.referenced_sg_id != null ? null : var.cidr_ipv4
  ip_protocol                  = var.ip_protocol
  from_port                    = var.from_port
  to_port                      = var.to_port
}

resource "aws_vpc_security_group_egress_rule" "default" {
  count                        = var.is_ingress_rule == true ? 0 : 1
  security_group_id            = local.sg_id
  referenced_security_group_id = local.referenced_sg_id != null ? local.referenced_sg_id : null
  cidr_ipv4                    = local.referenced_sg_id != null ? null : var.cidr_ipv4
  ip_protocol                  = var.ip_protocol
  from_port                    = var.from_port
  to_port                      = var.to_port
}
