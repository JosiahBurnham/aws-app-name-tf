#==========================================================
# File      : main.tf 
# Author    : J.Burnham
# Purpose   : Create GitHub Actions Access to AWS Account
#==========================================================

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}