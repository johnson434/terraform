mock_provider "aws" {}

run "create_ingress_which_source_is_referenced_sg" {
  command = plan
  variables {
    security_group_name            = "test"
    referenced_security_group_name = "r_sg"
    cidr_ipv4                      = null
    is_ingress_rule                = true
    ip_protocol                    = "tcp"
    from_port                      = 22
    to_port                        = 22
  }

  assert {
    condition     = length(aws_vpc_security_group_ingress_rule.default) == 1
    error_message = "Ingress rule is not created."
  }

  assert {
    condition     = length(aws_vpc_security_group_egress_rule.default) == 0
    error_message = "Passing Ingress but egress rule is created"
  }
}

run "create_ingress_which_source_is_cidr_ipv4" {
  command = plan
  variables {
    security_group_name            = "test"
    referenced_security_group_name = null
    cidr_ipv4                      = "10.0.0.0/16"
    is_ingress_rule                = true
    ip_protocol                    = "tcp"
    from_port                      = 22
    to_port                        = 22
  }

  assert {
    condition     = length(aws_vpc_security_group_ingress_rule.default) == 1
    error_message = "Ingress rule is not created."
  }

  assert {
    condition     = length(aws_vpc_security_group_egress_rule.default) == 0
    error_message = "Passing Ingress but egress rule is created"
  }

  assert {
    condition     = aws_vpc_security_group_ingress_rule.default[0].cidr_ipv4 == var.cidr_ipv4
    error_message = "입력한 cidr_ipv4와 보안그룹의 cidr_ipv4가 일치하지 않습니다."
  }
}

run "create_egress_which_source_is_referenced_sg" {
  command = plan
  variables {
    security_group_name            = "test"
    referenced_security_group_name = "r_sg"
    cidr_ipv4                      = null
    is_ingress_rule                = false
    ip_protocol                    = "tcp"
    from_port                      = 22
    to_port                        = 22
  }

  assert {
    condition     = length(aws_vpc_security_group_egress_rule.default) == 1
    error_message = "egress rule is not created."
  }

  assert {
    condition     = length(aws_vpc_security_group_ingress_rule.default) == 0
    error_message = "Passing egress but ingress rule is created"
  }
}

run "create_egress_which_source_is_cidr_ipv4" {
  command = plan
  variables {
    security_group_name            = "test"
    referenced_security_group_name = null
    cidr_ipv4                      = "10.0.0.0/16"
    is_ingress_rule                = false
    ip_protocol                    = "tcp"
    from_port                      = 22
    to_port                        = 22
  }

  assert {
    condition     = length(aws_vpc_security_group_egress_rule.default) == 1
    error_message = "egress rule is not created."
  }

  assert {
    condition     = length(aws_vpc_security_group_ingress_rule.default) == 0
    error_message = "Passing egress but ingress rule is created"
  }

  assert {
    condition     = aws_vpc_security_group_egress_rule.default[0].cidr_ipv4 == var.cidr_ipv4
    error_message = "입력한 cidr_ipv4와 보안그룹의 cidr_ipv4가 일치하지 않습니다."
  }
}

#run "when_sg_and_cidr_is_passed_then_variable_validation_check_will_fail" {
#  command = plan 
#  variables {
#    rule_info = {
#      security_group_name = "test"
#      referenced_security_group_name = "r-sg"
#      is_ingress_rule = true
#      cidr_ipv4 = "10.0.0.0/16"
#      ip_protocol = "tcp"
#      from_port = 22
#      to_port = 22
#    }
#  }
#
#  # command에서 명시한 단계에서 실패해야 예상한 에러로 받아들임.
#  expect_failures = [
#    var.rule_info
#  ]
#}
