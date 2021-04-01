//VPC
vpc_name                  = "hydradx-vpc"
cidr                      = "10.0.64.0/18"
public_subnets            = ["10.0.96.0/21", "10.0.104.0/21", "10.0.112.0/21"]
private_subnets           = ["10.0.64.0/21", "10.0.72.0/21", "10.0.80.0/21"]
is_nat_gateway_enabled    = true
is_single_nat_gateway     = true
are_dns_hostnames_enabled = true

//Subnets
availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]