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

##########################
# Create web network ACL #
##########################
# To prevent unwanted traffic from reaching web servers,
# create an ACL which restricts inbound and outbound
# subnet traffic. Development may be slightly more
# relaxed here than other environments

##############################
# Create web security groups #
##############################
# To further restrict unwanted traffic, create security
# groups for different classes of web servers.
# Development may be slightly more relaxed here than
# other environments