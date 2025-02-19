output "name" {
  value = coalesce(aws_route_table.default.tags["Name"], "test-1")
}
