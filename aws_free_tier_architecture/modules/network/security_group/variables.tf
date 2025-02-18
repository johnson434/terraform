variable "vpc_id" {
  type        = string
  description = "The VPC id to which security group belongs."
}

variable "name" {
  type = string
  description = "security group name"
}

variable "description" {
  type = string
  description = "security group description"
}
