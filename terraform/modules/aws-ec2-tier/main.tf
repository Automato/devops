resource "aws_security_group" "app_tier" {
  name = "${format("%s %s %s ec2", var.org_name, var.env_tier_name, var.app_tier_name)}"
  description = "${format("A security group for the %s ec2 instance tier, in the %s org, in the %s environment tier.", var.app_tier_name, var.org_name, var.env_tier_name)}"
  vpc_id = "${var.vpc_id}"
}
