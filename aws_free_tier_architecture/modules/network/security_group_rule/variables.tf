variable "security_group_name" {
  type        = string
  description = "rule이 부착될 보안그룹의 이름입니다."
}

variable "is_ingress_rule" {
  type        = bool
  description = "규칙이 ingress인지 egress인지 정하는 bool값입니다. true일 시에 ingress, false라면 egress입니다."
}

variable "src_dest" {
  type = object({
    type                           = string
    referenced_security_group_name = optional(string)
    cidr_ipv4                      = optional(string)
    cidr_ipv6                      = optional(string)
  })

  validation {
    condition     = anytrue([var.src_dest.type == "referenced_security_group_name", var.src_dest.type == "cidr_ipv4", var.src_dest.type == "cidr_ipv6"])
    error_message = "src_dest type은 referenced_security_group_name, cidr_ipv4, cidr_ipv6 중 하나여야 합니다."
  }
}

variable "ip_protocol" {
  type        = string
  description = "사용할 프로토콜입니다. 모든 프로토콜 허용 시에 -1"
}

variable "from_port" {
  type        = number
  description = "열어줄 포트 시작 번호입니다."
}

variable "to_port" {
  type        = number
  description = "열어줄 포트 끝 번호입니다."
}
