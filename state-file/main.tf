# s3 Bucket for Backend
resource "aws_s3_bucket" "newproject" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    Name = var.bucket_name
  }
}
# s3 Bucket Access Control List
resource "aws_s3_bucket_acl" "backend_bucket_acl" {
  bucket = var.bucket_name
  acl    = var.acl
}
################
# DYNAMODB TABLE
################
resource "aws_dynamodb_table" "newproject_tf-state-lock" {
  name     = var.table_name
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  write_capacity = 1
  read_capacity  = 1
  tags = {
    Name        = "newproject_tf-state-lock"
    Environment = "Terraform"
  }
}