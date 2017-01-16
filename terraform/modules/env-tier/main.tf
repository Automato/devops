resource "aws_vpc" "tier" {
  cidr_block = "${var.vpc_cidr_block}"
  instance_tenancy = "${var.vpc_instance_tenancy}"
  enable_dns_support = "${var.vpc_enable_dns_support}"
  enable_dns_hostnames = "${var.vpc_enable_dns_hostnames}"
  tags = {
    Name = "${format("%s %s", var.org_name, var.tier_name)}"
  }
}


resource "aws_subnet" "external" {
  count = "${length(var.vpc_zones)}"
  vpc_id = "${aws_vpc.tier.id}"
  availability_zone = "${element(var.vpc_zones, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr_block, 8, count.index)}"
  tags {
    Name = "${format("%s external %s %s", var.org_name, var.tier_name, element(var.vpc_zones, count.index))}"
  }
}

resource "aws_route_table" "external" {
  vpc_id = "${aws_vpc.tier.id}"
  tags {
    Name = "${format("%s external %s", var.org_name, var.tier_name)}"
  }
}

resource "aws_route_table_association" "external" {
  count = "${length(var.vpc_zones)}"
  route_table_id = "${aws_route_table.external.id}"
  subnet_id = "${element(aws_subnet.external.*.id, count.index)}"
}

resource "aws_route" "external_to_internet" {
  route_table_id = "${aws_route_table.external.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.tier.id}"
}

resource "aws_eip" "external" {
  count = "${length(var.vpc_zones)}"
  vpc = true
}

resource "aws_nat_gateway" "external" {
  count = "${length(var.vpc_zones)}"
  allocation_id = "${element(aws_eip.external.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.external.*.id, count.index)}"
  depends_on = [
    "aws_internet_gateway.tier"
  ]
}


resource "aws_subnet" "external_db" {
  count = "${length(var.vpc_zones)}"
  vpc_id = "${aws_vpc.tier.id}"
  availability_zone = "${element(var.vpc_zones, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr_block, 8, length(var.vpc_zones) + count.index)}"
  tags {
    Name = "${format("%s external_db %s %s", var.org_name, var.tier_name, element(var.vpc_zones, count.index))}"
  }
}

resource "aws_route_table" "external_db" {
  count = "${length(var.vpc_zones)}"
  vpc_id = "${aws_vpc.tier.id}"
  tags {
    Name = "${format("%s external_db %s %s", var.org_name, var.tier_name, count.index)}"
  }
}

resource "aws_route_table_association" "external_db" {
  count = "${length(var.vpc_zones)}"
  route_table_id = "${element(aws_route_table.external_db.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.external_db.*.id, count.index)}"
}

resource "aws_route" "external_db_to_nat" {
  count = "${length(var.vpc_zones)}"
  route_table_id = "${element(aws_route_table.external_db.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${element(aws_nat_gateway.external.*.id, count.index)}"
}


resource "aws_subnet" "internal" {
  count = "${length(var.vpc_zones)}"
  vpc_id = "${aws_vpc.tier.id}"
  availability_zone = "${element(var.vpc_zones, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr_block, 8, (length(var.vpc_zones) * 2) + count.index)}"
  tags {
    Name = "${format("%s internal %s %s", var.org_name, var.tier_name, element(var.vpc_zones, count.index))}"
  }
}

resource "aws_route_table" "internal" {
  count = "${length(var.vpc_zones)}"
  vpc_id = "${aws_vpc.tier.id}"
  tags {
    Name = "${format("%s internal %s %s", var.org_name, var.tier_name, count.index)}"
  }
}

resource "aws_route_table_association" "internal" {
  count = "${length(var.vpc_zones)}"
  route_table_id = "${element(aws_route_table.internal.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.internal.*.id, count.index)}"
}

resource "aws_route" "internal_to_nat" {
  count = "${length(var.vpc_zones)}"
  route_table_id = "${element(aws_route_table.internal.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${element(aws_nat_gateway.external.*.id, count.index)}"
}

resource "aws_subnet" "internal_db" {
  count = "${length(var.vpc_zones)}"
  vpc_id = "${aws_vpc.tier.id}"
  availability_zone = "${element(var.vpc_zones, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr_block, 8, (length(var.vpc_zones) * 3) + count.index)}"
  tags {
    Name = "${format("%s internal_db %s %s", var.org_name, var.tier_name, element(var.vpc_zones, count.index))}"
  }
}

resource "aws_route_table" "internal_db" {
  count = "${length(var.vpc_zones)}"
  vpc_id = "${aws_vpc.tier.id}"
  tags {
    Name = "${format("%s internal_db %s %s", var.org_name, var.tier_name, element(var.vpc_zones, count.index))}"
  }
}

resource "aws_route_table_association" "internal_db" {
  count = "${length(var.vpc_zones)}"
  route_table_id = "${element(aws_route_table.internal_db.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.internal_db.*.id, count.index)}"
}

resource "aws_route" "internal_db_to_nat" {
  count = "${length(var.vpc_zones)}"
  route_table_id = "${element(aws_route_table.internal_db.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${element(aws_nat_gateway.external.*.id, count.index)}"
}


resource "aws_internet_gateway" "tier" {
  vpc_id = "${aws_vpc.tier.id}"
  tags {
    Name = "${format("%s %s", var.org_name, var.tier_name)}"
  }
}
