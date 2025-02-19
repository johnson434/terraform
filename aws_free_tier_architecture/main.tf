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
  vpc_id   = module.vpc.id
  cidr_block = cidrsubnet(var.vpc_info.cidr_block, 8, count.index)
  az   = lookup(var.subnets, element(local.subnet_keys, count.index), null).az
}

module "nacl" {
  source = "./modules/network/nacl"

  vpc_id = module.vpc.id
  subnet_id = module.subnet[0].id
  nacl_rules = {
    "test" : {
      rule_number = 100
      ingress = true
      protocol = "tcp"
      rule_action = "deny"
      cidr_block = "0.0.0.0/0"
      from_port = 80
      to_port = 80
    }
  }
}

module "igw" {
  source = "./modules/network/igw"

  name     = var.igw_name
  vpc_id = module.vpc.id
}

module "security_group" {
  for_each = var.security_groups
  source   = "./modules/network/security_group"

  vpc_id      = module.vpc.id
  name        = each.key
  description = each.value.description
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

module "route_table_private" {
  source = "./modules/network/route_table"
  
  name = var.route_table_private.name
  vpc_name = module.vpc.name
  subnet_name = var.route_table_private.subnet_name
  depends_on = [module.subnet]
}

module "route_table_rule_private" {
  count = length(var.route_table_rule_private)
  source = "./modules/network/route_table_rule"

  route_table_name = module.route_table_private.name
  destination_cidr_block = element(var.route_table_rule_private, count.index).destination_cidr_block
  gateway = element(var.route_table_rule_private, count.index).gateway
  
  depends_on = [module.route_table_private]
}

