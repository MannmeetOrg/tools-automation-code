terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
#   access_key = "secret.AWS_ACCESS_KEY_ID"
#   secret_key = "secret.AWS_SECRET_ACCESS_KEY"
}