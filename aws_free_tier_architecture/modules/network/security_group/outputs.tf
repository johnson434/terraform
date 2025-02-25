output "id" {
  value = var.create_sg ? one(aws_security_group.default).id : one(data.aws_security_group.default).id
}
