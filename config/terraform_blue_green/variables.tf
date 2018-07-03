variable "subnets" {
  type    = "list"
  default = ["subnet-e770d5c9", "subnet-cf6864ab"]
}

variable "elb_subnet" {
  default = ["subnet-e770d5c9"]
}

variable "security_groups" {
  default = ["sg-25e8696e"]
}

