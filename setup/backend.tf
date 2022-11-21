# provider "aws" {
#     region = "us-east-1"
#     profile = "newkey"
#     shared_credentials_files = "~/.aws/credentials"
# }

# terraform {
#   backend "s3" {
#     bucket         = "newproject"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-1"
#     profile        =  "newaccess"
#     dynamodb_table = "newproject_tf-state-lock"
#   }
# }