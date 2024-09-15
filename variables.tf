variable "tools" {
  default = {
    github_runner = {
      instance_type = "t3.small"
      policy_name   = ["AdministratorAccess"]
      ports          = {}
      volume_size    = 20
    }
    vault = {
      instance_type = "t2.micro"
      policy_name   = []
      ports          = {
        vault = 8200
      }
      volume_size    = 20
    }
#     workstation = {
#       instance_type = "t3.small"
#       policy_name   = []
#       ports          = {}
#       volume_size    = 20
#     }
    }
}

variable "hosted_zone_id" {
  default = "Z070326013UBTG0W5AFBE"
}

# variable "AWS_ACCESS_KEY_ID" {}
# variable "AWS_SECRET_ACCESS_KEY" {}

#   type = map(object({
#     instance_type  = string
#     policy_name    = list(string)
#     ports          = map(number)  # Assuming ports are a map with port names as keys and port numbers as values
#     volume_size    = number
#   }))