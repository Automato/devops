# Create a security group for the database to use by default
resource "aws_security_group" "postgres_db" {
  count = "${var.security_group_id == "" ? 1 : 0}"
  name = "${format("%s %s %s postgres_db", var.org_name, var.tier_name, var.db_name)}"
  description = "${format("A security group for the %s postgres db instance, in the %s org, in the %s environment tier.", var.db_name, var.org_name, var.tier_name)}"
  vpc_id = "${var.vpc_id}"
}

