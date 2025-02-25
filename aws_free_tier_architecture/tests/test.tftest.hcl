run "s3_create_test" {
  command = plan

  variables {
    bucket_name = "test10101021"
  }

  module {
    source = "./modules/s3"
  }

  assert {
    condition     = var.bucket_name == "test10101021"
    error_message = "bucket_name is not i want"
  }
}
