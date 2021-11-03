variable "region" {
  default     = "ap-southeast-1"
  description = "AWS region"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

provider "aws" {
  region = var.region
}

#data "aws_availability_zones" "available" {}

locals {
  vpc_id                = "vpc-098b9805814c2c1a9"
  cluster_name          = "eks-${random_string.suffix.result}"
  availability_zone     = ["ap-southeast-1a", "ap-southeast-1b"] #, "ap-southeast-1c"]
  infra_node_size       = 1
  work_node_size        = 2
  private_subnets       = ["10.0.1.0/24", "10.0.2.0/24"] #, "10.0.3.0/24"]
  public_subnets        = ["10.0.4.0/24", "10.0.5.0/24"] #, "10.0.6.0/24"]
}

data "aws_vpc" "versent_lab" {
  id    = local.vpc_id

  filter {
    name   = "tag:Name" 
    values = ["versent-sg-lab-vpc"] 
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = local.vpc_id

  tags = {
    Tier = "Private"
  }
}

data "aws_subnet" "private" {
  for_each = data.aws_subnet_ids.private.ids
  id       = each.value
}