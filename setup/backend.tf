# provider "aws" {
#     region = "us-east-1"
#     profile = "newkey"
#     shared_credentials_files = "~/.aws/credentials"
# }

# terraform {
#   backend "s3" {
#     bucket         = "jengomart"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-1"
#     profile        =  "newaccess"
#     dynamodb_table = "jengomart_tf-state-lock"
#   }
# }