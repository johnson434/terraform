resource "aws_s3_bucket" "user_data" {
  bucket = var.bucket_name
  provisioner "local-exec" {
    command = <<EOC
      aws s3 rm s3://${self.id} --recursive
    EOC
  }
}
