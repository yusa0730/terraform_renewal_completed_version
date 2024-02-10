provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.4.0"
    }
  }
  backend "s3" {
    bucket = "terraform-renewal-completed"
    key    = "stg/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
