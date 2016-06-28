module "vpc" {
  source = "../modules/aws-vpc"
  name = "Automato Development"
  cidr = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

module "subnet-a" {
}

module "subnet-b" {
}

module "subnet-d" {
}

module "subnet-e" {
}
