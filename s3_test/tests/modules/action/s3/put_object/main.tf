resource "aws_s3_object" "test_file" {
  for_each = var.s3_objects

  bucket = var.s3_bucket_name
  key = each.key
  source = each.value

  etag = filemd5(each.value)
}

output "length_of_object" {
  value = length(keys(aws_s3_object.test_file))
}
