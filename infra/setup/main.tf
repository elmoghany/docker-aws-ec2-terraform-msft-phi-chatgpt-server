terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  
  default_tags {
    tags = {
    Environment = terraform.workspace
    Project     = var.project
    Contact     = var.contact
    ManageBy    = "Terraform/setup"
	}
  }
}

resource "aws_s3_bucket" "tf_phi3_s3_storage"{
  bucket = "tf_phi3_s3_storage_name"
  versioning {
    enabled = true
  }

}

resource "aws_instance" "tf_phi3_ec2_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

