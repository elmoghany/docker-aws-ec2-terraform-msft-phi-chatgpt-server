# use an S3 bucket to store the Terraform state
# DynamoDB table to manage state locking

# We use the “setup” and “deploy” terraform so we can include both the AWS setup steps (e.g. creating the IAM user for our automated CI/CD workflows) and our application deployment steps in our codebase

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.55.0"
    }
  }

  backend "s3" {
    bucket = "tf_phi3_s3_storage"
    region = var.region
    encrypt = true
    dynamodb_table = "tf-phi3-s3-dyanmo-tf-lock"
  }
}

provider "aws" {
  region  = var.region
  
  default_tags {
    tags = {
    Environment = terraform.workspace
    Project     = var.project
    Contact     = var.contact
    ManageBy    = "Terraform/deploy"
	}
  }
}

resource "aws_s3_bucket" "phi3_storage"{
  acl = "public-read"

  versioning {
    enabled = true
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}

data "aws_region" "current"{}