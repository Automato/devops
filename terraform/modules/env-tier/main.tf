resource "aws_vpc" "tier_vpc" {
  cidr_block = "${var.vpc_cidr_block}"
  instance_tenancy = "${var.vpc_instance_tenancy}"
  enable_dns_support = "${var.vpc_enable_dns_support}"
  enable_dns_hostnames = "${var.vpc_enable_dns_hostnames}"
  tags = {
    Name = "${format("%s %s", var.org_name, var.tier_name)}"
  }
}

resource "aws_subnet" "tier_subnet" {
  count = "${length(var.vpc_zones)}"
  vpc_id = "${aws_vpc.tier_vpc.id}"
  availability_zone = "${element(var.vpc_zones, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr_block, 8, count.index)}"
  tags {
    Name = "${format("%s %s %s", var.org_name, var.tier_name, element(var.vpc_zones, count.index))}"
  }
}

resource "aws_internet_gateway" "tier_gateway" {
  vpc_id = "${aws_vpc.tier_vpc.id}"
  tags {
    Name = "${format("%s %s", var.org_name, var.tier_name)}"
  }
}
