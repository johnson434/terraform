# S3 Bucket 테스트
## 디렉터리 구조
``` tree
.
├── main.tf								
├── modules								
├── outputs.tf
├── README.md
├── terraform.tf
├── tests														# 테스트 파일들의 루트 디렉터리
│   ├── modules												# 테스트를 위해 사용될 모듈 디렉터리
│   │   ├── action											# 테스트 액션들을 저장한 디렉터리 
│   │   │   └── s3												# 테스트 최소 단위
│   │   │       └── put_object
│   │   └── set_up										# 테스트를 위한 사전 설정 파일 (예: S3 Object 테스트를 위한 버켓 생성)
│   │       └── s3											# 사전 설정 최소 단위
│   │           └── create_bucket
│   └── s3_test.tftest.hcl
└── variables.tf

11 directories, 28 files
```

## 버켓 삭제 자동화
- 버켓은 내부가 빈(Empty) 상태가 아니라면 삭제가 불가능하다.
- 테스트 자동화를 위해 `lifecycle`을 통해서 삭제 자동화
``` hcl
resource "aws_s3_bucket" "web_service" {
  bucket = var.s3_bucket_name

  tags = {
    Name = var.s3_bucket_name
  }
  
  # Provisioner를 통해서 S3가 삭제되기 전에 버켓 내부를 비운다.
  provisioner "local-exec"{
    when = destroy
    command = <<EOC
      aws s3 rm s3://${self.id} --recursive
    EOC
  }
}
```
