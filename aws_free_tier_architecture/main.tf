module "vpc" {
  source = "./modules/network/vpc"

  vpc_name       = var.vpc_info.name
  vpc_cidr_block = var.vpc_info.cidr_block
}

module "subnet" {
  count = length(var.subnets)
  source = "./modules/network/subnet"

  name = var.subnets[count.index].name
  vpc_name = var.subnets[count.index].vpc_name
  cidr_block = cidrsubnet(var.vpc_info.cidr_block, 4, count.index)
  az = var.subnets[count.index].az
  
  depends_on = [module.vpc]
}

module "security_group" {
  for_each = var.security_groups
  source   = "./modules/network/security_group"

  vpc_id      = module.vpc.id
  name        = each.key
  description = each.value.description

  depends_on = [module.vpc]
}

module "security_group_rules" {
  for_each = var.security_group_rules
  source   = "./modules/network/security_group_rule"

  security_group_name            = each.value.security_group_name
  referenced_security_group_name = each.value.security_group_name
  is_ingress_rule                = each.value.is_ingress_rule
  cidr_ipv4                      = each.value.cidr_ipv4
  ip_protocol                    = each.value.ip_protocol
  from_port                      = each.value.from_port
  to_port                        = each.value.to_port

  depends_on = [module.security_group]
}

module "igw" {
  source   = "./modules/network/igw"

  name     = var.igw_name
  vpc_name = module.vpc.name

  depends_on = [module.vpc]
}
