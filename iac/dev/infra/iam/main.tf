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

resource "aws_iam_policy" "gh_actions_assume_role_policy" {
  name = "gh-policy-dev-01"
  path = "/"
  description = "Policy for GH Actions Assume Role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow"
            Action = "ec2:Describe*"
            Resource = "*"
        }
    ]
  })
}

resource "aws_iam_role" "gh_actions_assume_role" {
  name = "gh-actions-dev-role-01"
  managed_policy_arns = [aws_iam_policy.gh_actions_assume_role_policy.arn]
  assume_role_policy = jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [
        {
          "Version": "2012-10-17",
          "Statement": [
              {
                  "Effect": "Allow",
                  "Principal": {
                      "Service": "ec2.amazonaws.com"
                  },
                  "Action": "sts:AssumeRole"
              }
          ]
        }
    ]
}
  )
}