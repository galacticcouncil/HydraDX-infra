provider "aws" {
  region = var.region
  shared_credentials_file = ""
  profile = "hydradx"
}

resource "aws_eip" "nat" {
  count = 3
  vpc = true
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.70.0"

  name                 = var.vpc_name
  cidr                 = var.cidr
  azs                  = var.availability_zones
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = var.is_nat_gateway_enabled
  single_nat_gateway   = var.is_single_nat_gateway
  enable_dns_hostnames = var.are_dns_hostnames_enabled

  tags = {
    Terraform = "true"
    Environment = var.environment
    Type = "testing-workload"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

}
