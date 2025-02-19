module "vpc" {
  source = "./modules/network/vpc"

  vpc_name       = var.vpc_info.name
  vpc_cidr_block = var.vpc_info.cidr_block
}

locals {
  subnet_keys = keys(var.subnets)
}

module "subnet" {
  count = length(keys(var.subnets))
  source   = "./modules/network/subnet"

  name       = element(local.subnet_keys, count.index)
  vpc_name   = lookup(var.subnets, element(local.subnet_keys, count.index), null).vpc_name
  cidr_block = cidrsubnet(var.vpc_info.cidr_block, 8, count.index)
  az   = lookup(var.subnets, element(local.subnet_keys, count.index), null).az
  depends_on = [module.vpc]
}

module "igw" {
  source = "./modules/network/igw"

  name     = var.igw_name
  vpc_name = module.vpc.name

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

  security_group_name = each.value.security_group_name
  is_ingress_rule     = each.value.is_ingress_rule
  src_dest            = each.value.src_dest
  ip_protocol         = each.value.ip_protocol
  from_port           = each.value.from_port
  to_port             = each.value.to_port

  depends_on = [module.security_group]
}

