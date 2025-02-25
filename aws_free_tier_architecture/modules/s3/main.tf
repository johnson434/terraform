resource "aws_s3_bucket" "user_data" {
  bucket = var.bucket_name

  provisioner "local-exec" {
    when = destroy
    environment = {
      bucket_name = self.bucket
    }
    command = "${path.module}/scripts/empty_bucket.sh $bucket_name"
  }
}

