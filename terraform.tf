terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }

    http = {
      source  = "terraform-aws-modules/http"
      version = ">= 2.4.1"
    }
  }

  required_version = "~> 1.5"
}
