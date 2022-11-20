terraform {
#   backend "s3" {
#     bucket = "" # bucket should be present
#     key    = ""
#     region = "us-east-1"
#   }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}