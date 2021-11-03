terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }
  required_version = "> 0.14"

  backend "s3" {
    bucket         = "versent-lab-tfstate"
    #eks_eks-qX8jjaoB
    #${variable.cluster_name.toreplace}
    key            = "terraform_${variable.cluster_name.toreplace}/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "versent-lab-tflocks"
    encrypt        = true
  }
}

