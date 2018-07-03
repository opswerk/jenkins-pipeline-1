variable "infrastructure_version" {
  default = "1"
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "opswerk-blue-green"
    region  = "us-east-1"
    key     = "v1"
  }
}

