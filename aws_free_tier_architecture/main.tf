locals {
  subnet_keys = keys(var.subnets)
}

module "vpc" {
  source = "./modules/network/vpc"
  
  vpc_name       = var.vpc_info.name
  vpc_cidr_block = var.vpc_info.cidr_block
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

module "alb_security_group" {
  source = "./modules/network/security_group"
  create_sg = true
  vpc_id = module.vpc.id
  name = "ALB"
  description = "alb sg"

  ingress_rules_cidr_ipv4 = [{
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port = 443
    to_port = 443
  }]
}

module "web_security_group_a" {
  source = "./modules/network/security_group"
  create_sg = true
  vpc_id = module.vpc.id
  name = "test-sg"
  description = "test-sg dd"

  ingress_rules_referenced_sg = [
    {
      referenced_sg_id = module.alb_security_group.id
      ip_protocol = "tcp"
      from_port = 80
      to_port = 80
    }, 
    {
      referenced_sg_id = module.alb_security_group.id
      ip_protocol = "tcp"
      from_port = 443
      to_port = 443
    }
  ]
}
