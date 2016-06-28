# Create a VPC to contain development environment
module "vpc" {
  source = "../modules/aws-vpc"
  name = "Automato Development"
  cidr = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

