terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }
}

provider "aws" {
  region  = var.region
  
  default_tags {
    tags = {
    Environment = terraform.workspace
    Project     = var.project
    Contact     = var.contact
    ManageBy    = "Terraform/setup"
	}
  }
}

resource "aws_s3_bucket" "phi3_storage"{
  bucket = "tf_phi3_s3_tf_state"
  acl = "public-read"

  versioning {
    enabled = true
  }
}

resource "aws_instance" "tf_phi3_ubuntu_ec2_server" {
  ami           = "ami-0cf2b4e024cdb6960"
  instance_type = "t2.micro"
}

