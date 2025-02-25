variable "vpc_info" {
  type = object({
    name       = string
    cidr_block = string
  })

  description = "Main VPC that every aws service will use"
}

variable "subnets" {
  type = map(object({
    vpc_name = string
    az       = string
  }))

  description = "사용할 서브넷 집합. key가 subnet의 이름"
}

variable "igw_name" {
  type        = string
  description = "IGW 이름"
}

variable "route_table_private" {
  type = object({
    name = string
    vpc_name = string
    subnet_name = string
  })
}

variable "route_table_rule_private" {
  type = list(object({
    destination_cidr_block = string
    gateway = object({
      type = string
      name = string
    })
  }))
}
