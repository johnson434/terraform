variable "vpc_id" {
  type = string
  description = "NACL이 속할 VPC"
}

variable "subnet_id" {
  type = string
  description = "NACL이 적용될 서브넷"
}

variable "nacl_rules" {
  type = map(object({
      rule_number = number
      ingress = optional(bool)
      egress = optional(bool)
      protocol = string
      rule_action = string
      cidr_block = string
      from_port = number
      to_port = number
  }))
}
