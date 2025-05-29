terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    key = "personal-project/terraform.tfstate"
    bucket = "one-cool-thing"
    dynamodb_table = "terraform-lock-table"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
