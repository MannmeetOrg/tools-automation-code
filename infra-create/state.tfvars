bucket = "tool-infra-create"
key    = "tools/terraform.tfstate"
region = "us-east-1"



# terraform {
#   backend "s3" {
#
# }
# data "terraform_remote_state" "remotetf" {
#   backend = "s3"
#   config = {
#     bucket = "tool-infra-create"
#     key    = "remotetf/terraform.tfstate"
#     region = "us-east-1"
#   }
# }
