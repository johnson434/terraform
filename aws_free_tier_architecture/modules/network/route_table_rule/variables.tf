variable "route_table_name" {
  type        = string
  description = "route table name"
}

variable "destination_cidr_block" {
  type        = string
  description = "destination cidr block"
}

variable "gateway" {
  type = object({
    type = string
    name = string
  })
  description = "gateway name"
  nullable    = true

  validation {
    condition = anytrue([var.gateway.type == "nat", var.gateway.type == "igw", var.gateway.type == "local"])
    error_message = "type should be nat or igw or local"
  }
}
