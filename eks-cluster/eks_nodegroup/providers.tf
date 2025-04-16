provider "aws" {
  region = "us-east-1"
  
}
terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = ">=2.11.0"  # Use the latest version available
    }
    kubectl = {
      source = "bnu0/kubectl"
      version = "0.27.0"
    }
  }

  backend "s3" {
    region = "us-east-1"
    bucket = "salil-terraform"
    key    = "eks_cluster_monitoring.tfstate"
  }
}
