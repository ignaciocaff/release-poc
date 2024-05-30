terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.37"
    }
  }
  required_version = ">= 1.1.0"
}
