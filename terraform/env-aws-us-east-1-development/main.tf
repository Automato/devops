module "aws-vpc" {
  source = "../modules/aws-vpc"
  env = "dev"
  cidr = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}
