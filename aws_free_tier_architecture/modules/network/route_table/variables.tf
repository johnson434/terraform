variable "route_table_name" {
  type        = string
  description = "Route Table name"
}

variable "vpc_id" {
  type = string
  description = "라우트테이블이 속할 VPC ID"
}

variable "associated_subnet_ids" {
  type = list(string)
  description = "라우트 테이블이랑 협력하는 서브넷 아이디들"
}

variable "aws_routes" {
  type = list(object({
    destination_cidr_block = string
    gateway_id = string
  }))
  description = "로컬 라우트 룰"
}
