
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
      
    }
  }
}



provider "aws" {
  alias      = "this"
  region     = "eu-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "aws" {
  alias      = "peer"
  region     = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

