terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider Configuration
provider "aws" {
  region = var.aws_default_region
}

# Production S3 Remote State Backend (Uncomment and customize to enable team state locking)
# terraform {
#   backend "s3" {
#     bucket         = "quiz-app-tfstate-bucket"
#     key            = "env/prod/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "terraform-state-locks"
#     encrypt        = true
#   }
# }
