# aws configure 없이 확인하려고 mock으로 확인
mock_provider "aws" {}

variables {
  vpc_id      = "vpc_id"
  name        = "blahblah"
  description = "blahblah"
}

run "is_security_group_name_equal_to_variable" {
  assert {
    condition     = aws_security_group.default.name == "blahblah"
    error_message = "security_group is not blahblah name: ${aws_security_group.default.name}"
  }
}

run "is_security_group_tags_equal_to_name" {
  assert {
    condition     = aws_security_group.default.name == aws_security_group.default.tags["Name"]
    error_message = "security_group name and tag name aren't equal. ${aws_security_group.default.name} ${aws_security_group.default.tags["Name"]}"
  }
}
