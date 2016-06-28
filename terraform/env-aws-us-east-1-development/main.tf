# Create a VPC to contain development environment
module "vpc" {
  source = "../modules/aws-vpc"
  name = "Automato Development"
  cidr = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

######################
# Create web subnets #
######################
# To promote high availability within the region,
# create a subnet in each availability zone within
# the region.

# Create a web subnet in region us-east-1a
module "web-subnet-a" {
  source = "../modules/aws-vpc-subnet"
  name = "Automato Development Web A"
  vpc_id = "${module.vpc.vpc_id}"
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/24"
}

# Create a web subnet in region us-east-1b
module "web-subnet-b" {
  source = "../modules/aws-vpc-subnet"
  name = "Automato Development Web B"
  vpc_id = "${module.vpc.vpc_id}"
  availability_zone = "us-east-1b"
  cidr_block = "10.0.1.0/24"
}

# Create a web subnet in region us-east-1d
module "web-subnet-d" {
  source = "../modules/aws-vpc-subnet"
  name = "Automato Development Web D"
  vpc_id = "${module.vpc.vpc_id}"
  availability_zone = "us-east-1d"
  cidr_block = "10.0.2.0/24"
}

# Create a web subnet in region us-east-1e
module "web-subnet-e" {
  source = "../modules/aws-vpc-subnet"
  name = "Automato Development Web E"
  vpc_id = "${module.vpc.vpc_id}"
  availability_zone = "us-east-1e"
  cidr_block = "10.0.3.0/24"
}
