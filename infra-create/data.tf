data "aws_ami" "rhel9" {
  most_recent = true

  name_regex = "RHEL-9-DeOps-Practice.*"

  owners = ["973714476881"]
}

# data "terraform_remote_state" "remotetf" {
#   backend = "s3"
#   config = {
#     bucket = "tool-infra-create"
#     key    = "remotetf/terraform.tfstate"
#     region = "us-east-1"
#   }
# }
