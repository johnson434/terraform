variable "vpc_info" {
  type = object({
    name = string
    cidr_block = string
  })

  description = "Main VPC that every aws service will use"
}

variable "igw_name" {
  type = string
  description = "IGW 이름"
}

variable "security_groups" {
  type = map(object({
    description = string
  }))

  description = "Security group. 추후에 추가적으로 입력 값을 받을 수 있을 것 같아서 value는 object형으로 선언함"
}

variable "security_group_rules" {
  type = map(
    object({
      security_group_name = string
      is_ingress_rule     = bool
      referenced_security_group_name = optional(string)
      cidr_ipv4           = optional(string)
      ip_protocol         = string
      from_port           = number
      to_port             = number
    })
  )

  description = "Security group rules"
}
