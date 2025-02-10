resource "terraform_data" "make_backup_files" {
  triggers_replace = [
    aws_s3_bucket.web_service.tags_all["Name"]
  ]
}

resource "aws_s3_bucket" "web_service" {
  bucket = var.s3_bucket_name

  tags = {
    Name = var.s3_bucket_name
  }

  provisioner "local-exec"{
    when = destroy
    command = <<EOC
      aws s3 rm s3://${self.id} --recursive
    EOC
  }
}
