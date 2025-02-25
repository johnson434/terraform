variable "create_sg" {
  type = bool
  description = "bool to decide neither create sg. if true then create sg or search the sg and using that sg to attach security_group_rule."
}

variable "vpc_id" {
  type        = string
  description = "The VPC id to which security group belongs."
}

variable "name" {
  type        = string
  description = "security group name"
}

variable "description" {
  type        = string
  description = "security group description"
}

variable "ingress_rules_referenced_sg" {
  type = list(object({
    referenced_sg_id = optional(string)
    ip_protocol = optional(string)
    from_port = number
    to_port = number
  }))

  nullable = true
  default = null
}

variable "ingress_rules_cidr_ipv4" {
  type = list(object({
    cidr_ipv4 = optional(string)
    ip_protocol = optional(string)
    from_port = number
    to_port = number
  }))

  nullable = true
  default = null
}

variable "ingress_rules_cidr_ipv6" {
  type = list(object({
    cidr_ipv6 = optional(string)
    ip_protocol = optional(string)
    from_port = number
    to_port = number
  }))

  nullable = true
  default = null
}

variable "egress_rules_referenced_sg" {
  type = list(object({
    referenced_sg_id = optional(string)
    ip_protocol = optional(string)
    from_port = number
    to_port = number
  }))

  nullable = true
  default = null
}

variable "egress_rules_cidr_ipv4" {
  type = list(object({
    cidr_ipv4 = optional(string)
    ip_protocol = optional(string)
    from_port = number
    to_port = number
  }))

  nullable = true
  default = null
}

variable "egress_rules_cidr_ipv6" {
  type = list(object({
    cidr_ipv6 = optional(string)
    ip_protocol = optional(string)
    from_port = number
    to_port = number
  }))

  nullable = true
  default = null
}
