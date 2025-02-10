variables {
  s3_bucket_name = "my-test-203123"
  s3_objects = {
    "file0" : "./tests/modules/set_up/s3/create_bucket/backup_files/testfile0"
  }
}

run "s3_create_bucket" {
  module {
    source = "./tests/modules/set_up/s3/create_bucket"
  }
}

run "s3_put_object" {
  module {
    source = "./tests/modules/action/s3/put_object"
  }
}

run "is_put_object_success" {
  assert {
    condition     = run.s3_put_object.length_of_object == 1
    error_message = "Put Object failed: length of object is not equal to zero."
  }
}
