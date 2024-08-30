terraform {
  backend "s3" {
    bucket = "tool-infra-create"
    key    = "tools/terraform.tfstate"
    region = "us-east-1"
  }
}
