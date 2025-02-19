variable "name" {
  type        = string
  description = "Route Table name"
}

variable "vpc_name" {
  type        = string
  description = "The VPC ID to which the route table belongs."
}

variable "subnet_name" {
  type        = string
  description = "The Subnet name to which associate with route_table"
}
