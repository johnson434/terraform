variable "security_group_name" {
  type = string
  description = "rule이 부착될 보안그룹의 이름입니다."
}

variable "referenced_security_group_name" {
  type = string
  description = "src 혹은 dest가 될 보안그룹입니다. referenced_security_group_name과 cidr_ipv4 중 하나만 필요하다."
  nullable = true
}

variable "is_ingress_rule" {
  type = bool
  description = "규칙이 ingress인지 egress인지 정하는 bool값입니다. true일 시에 ingress, false라면 egress입니다."
}

variable "cidr_ipv4" {
  type = string
  description = "src 혹은 dest가 될 cidr입니다.  referenced_security_group_name과 cidr_ipv4 중 하나만 필요합니다."
  nullable = true
}

variable "ip_protocol" {
  type = string 
  description = "사용할 프로토콜입니다. 모든 프로토콜 허용 시에 -1" 
}

variable "from_port" {
  type = number 
  description = "열어줄 포트 시작 번호입니다." 
}

variable "to_port" {
  type = number
  description = "열어줄 포트 끝 번호입니다."
}

#variable "rule_info" {
#  type = object({  
#    ip_protocol         = string
#    from_port           = number
#    to_port             = number
#  })
#
#  description = "Security Group을 위한 variable입니다. security_group_name은 rule이 속한 보안그룹이고 referenced_security_group_id는 출발지나 도착지의 보안 그룹입니다."
#
#  validation {
#    condition = anytrue([var.rule_info.cidr_ipv4 == null, var.rule_info.referenced_security_group_name == null]) != alltrue([var.rule_info.cidr_ipv4 == null, var.rule_info.referenced_security_group_name == null]) 
#    error_message = "Only one parameter needed between referenced_security_group_name and cidr_ipv4"
#  }
#}
