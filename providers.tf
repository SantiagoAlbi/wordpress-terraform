terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Management = "Terraform"
    }
  }
}

# VER SI UTILIZO PARA TF.STATE DEL BACKEND EN S3 O LOCAL
/*
terraform {                       
  backend "s3" {
    bucket = "Quirquirimichi-1996"
    key = "vpc.tfstate"
    dynamodb_table = "tf-backend"
    encrypt = true
    region = "us-eats-1"
  }
}
*/
