terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA57AYMZAZDBISR25E"
  secret_key = "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"
}