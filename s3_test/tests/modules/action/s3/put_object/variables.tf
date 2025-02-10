variable "s3_bucket_name" {
  type = string
  description = "Name of the s3 bucket"
}

variable "s3_objects" {
  type = map(string)
  description = "Map of files to test S3 PutObject automation."
}
